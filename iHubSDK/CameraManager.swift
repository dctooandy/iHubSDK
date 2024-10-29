//
//  CameraManager.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/29.
//

import Foundation
import RxSwift


enum ConnectCameraErrors: Codable {
    case notInitializing(NSInteger)
    case informationNotComplete(NSInteger)
    case authenticationOfIPCamWrong(NSInteger)
    case connectionFail(NSInteger)
    case connectionQueueFull(NSInteger)
    case connectionPortMappingWrror(NSInteger)
    case defaultError(NSInteger)
    
    var title: String {
        switch self {
        case .notInitializing(let index):
            return "\(index)" + "此裝置離線中，\n是否仍要儲存？".localized()
        case .informationNotComplete(let index):
            return "\(index)" + "此裝置離線中，\n是否仍要儲存？".localized()
        case .authenticationOfIPCamWrong(let index):
            return "\(index)" + "此裝置帳號或者密碼錯誤，\n是否仍要儲存？".localized()
        case .connectionFail(let index):
            return "\(index)" + "此裝置離線中，\n是否仍要儲存？".localized()
        case .connectionQueueFull(let index):
            return "\(index)" + "此裝置離線中，\n是否仍要儲存？".localized()
        case .connectionPortMappingWrror(let index):
            return "\(index)" + "此裝置Port錯誤，\n是否仍要儲存？".localized()
        case .defaultError(let index):
            return "\(index)" + "此裝置離線中，\n是否仍要儲存？".localized()
        }
    }
}

public class CameraManager {
    // property
    public static let shared = CameraManager()
    private var nodeModelDic: [String: CameraModel] = [:]
    public var onRefreshNode: (() -> Void)?
#if !targetEnvironment(simulator)
    private var nodeDic: [String: ConnectNode] = [:]
    // func
    private init() {
        self.getCameraAll()
    }
    
    func cameraNodeInit(_ key: String, completion: @escaping () -> Void) {
        if !self.nodeDic.keys.contains(key) {
            let cameraNode = ConnectNode()
            let deviceInitializeFlag = cameraNode.initialize(1)
            if deviceInitializeFlag >= 0 {
                self.nodeDic[key] = cameraNode
                completion()
            } else {
                switch deviceInitializeFlag {
                case -1:
                    print("執行 Camera Initialize Error:The connection manager size is error")
                case -2:
                    print("執行 Camera Initialize Error:The connection manager queue has been already initialized.")
                default:
                    print("執行 Camera Initialize Error:異常")
                }
            }
        } else {
            completion()
        }
    }
    
    func addCameraModel(_ key: String, model: CameraModel) {
        nodeModelDic[key] = model
    }
    
    func getNode(_ key: String) -> ConnectNode? {
        return nodeDic[key]
    }
    
    func getModel(_ key: String) -> CameraModel? {
        return nodeModelDic[key]
    }
    
    func refreshNode() {
        self.onRefreshNode?()
        self.nodeDic.removeAll()
        self.nodeModelDic.removeAll()
        self.getCameraAll()
    }
    
    func getCameraAll() {
        //        self.cameraAllDataDisposeBag = DisposeBag()
        //
        //        self.cameraController.getAll()
        //            .observe(on: MainScheduler.instance)
        //            .subscribe(onNext: { models in
        //                for model in models {
        //                    self.initAndConnectWithModel(model) { _, _ in }
        //                }
        //            })
        //            .disposed(by: self.cameraAllDataDisposeBag)
    }
    
    public func initAndConnectWithModel(_ model: CameraModel, completion: @escaping (NSInteger, ConnectNode?) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.main.async {
            self.cameraNodeInit(model.key) {
                self.addCameraModel(model.key, model: model)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .global()) {
            self.connectNodeByModel(model, completion: completion)
        }
    }
    
    func connectNodeByModel(_ model: CameraModel, completion: @escaping (NSInteger, ConnectNode?) -> Void) {
        var deviceInfo: [String: Any] = [
            "name": model.title,
            "user": model.username,
            "passwd": model.password,
            "p2pAccount": "nodata",
            "p2pPassword": "nodata",
            "isHttps": false
        ]
        if model.ip.split(separator: ".").count > 2 {
            deviceInfo["hostAddress"] = model.ip
            deviceInfo["port"] = model.port
        } else {
            deviceInfo["p2pUid"] = model.ip
        }
        var connectNodeFlag: NSInteger = -1
        if let node = self.getNode(model.key) {
            connectNodeFlag = node.connectNode(deviceInfo)
            if connectNodeFlag >= 0 || connectNodeFlag == -100 {
                completion(1, node)
            } else {
                completion(connectNodeFlag, node)
            }
        } else {
            completion(connectNodeFlag, nil)
        }
    }
    
    func fetchConnectCameraError(_ connectFlag: NSInteger) -> ConnectCameraErrors {
        var error = ConnectCameraErrors.defaultError(connectFlag)
        switch connectFlag {
        case -3:
            error = .notInitializing(connectFlag)
            print("執行 Camera ConnectNode Error:The connection manager is not initializing yet.")
        case -4:
            error = .informationNotComplete(connectFlag)
            print("執行 Camera ConnectNode Error:The connection information is not complete.")
        case -5:
            error = .authenticationOfIPCamWrong(connectFlag)
            print("執行 Camera ConnectNode Error:The authentication of IPCam is wrong.")
        case -6:
            error = .connectionFail(connectFlag)
            print("執行 Camera ConnectNode Error:The connection is fail.")
        case -100:
            error = .connectionQueueFull(connectFlag)
            print("執行 Camera ConnectNode Error:The connection queue is full.")
        case -5566:
            error = .connectionPortMappingWrror(connectFlag)
            print("執行 Camera ConnectNode Error:The connection port mapping error")
        case -30019:
            print("執行 Camera ConnectNode Error:超過10台P2P同時連線狀態")
        default:
            error = .defaultError(connectFlag)
            print("執行 Camera ConnectNode Error:異常")
        }
        return error
    }
    
    func getDeviceInfo(_ key: String) -> CameraDeviceInfoModel? {
        if let node = self.getNode(key) {
            let deviceInfo = node.getDeviceInfo()
            guard let dictionary = deviceInfo as? [String: Any] else {
                print("執行 Camera Dictionary is nil or not in the correct format.")
                return nil
            }
            let hostAddress = dictionary["hostAddress"] as? String ?? ""
            let port = self.stringValue(from: dictionary["port"])
            let model = CameraDeviceInfoModel(
                user: dictionary["user"] as? String ?? "",
                p2pAccount: dictionary["p2pAccount"] as? String ?? "",
                isHttps: self.stringValue(from: dictionary["isHttps"]), // 假設是 Int，轉換為 String
                p2pMappingIndex: self.stringValue(from: dictionary["p2pMappingIndex"]), // 假設是 Int，轉換為 String
                p2pPassword: dictionary["p2pPassword"] as? String ?? "",
                p2pSid: self.stringValue(from: dictionary["p2pSid"]), // 假設是 Int，轉換為 String
                port: port, // 假設是 Int，轉換為 String
                p2pUid: dictionary["p2pUid"] as? String ?? "",
                hostAddress: hostAddress,
                passwd: dictionary["passwd"] as? String ?? "",
                name: dictionary["name"] as? String ?? ""
            )
            return model
        } else {
            print("執行 Camera Node nil")
            return nil
        }
    }
    
    func stringValue(from value: Any?) -> String {
        if let intValue = value as? Int {
            return "\(intValue)"
        } else if let stringValue = value as? String {
            return stringValue
        }
        return "0" // 預設值
    }
#else
    
#endif

}
