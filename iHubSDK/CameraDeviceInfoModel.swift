//
//  CameraDeviceInfoModel.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/29.
//

import Foundation
public struct CameraDeviceInfoModel {
    public var user: String = ""
    public var p2pAccount: String = ""
    public var isHttps: String = ""
    public var p2pMappingIndex: String = ""
    public var p2pPassword: String = ""
    public var p2pSid: String = ""
    public var port: String = ""
    public var p2pUid: String = ""
    public var hostAddress: String = ""
    public var passwd: String = ""
    public var name: String = ""
    
    init(user: String, p2pAccount: String, isHttps: String, p2pMappingIndex: String, p2pPassword: String, p2pSid: String, port: String, p2pUid: String, hostAddress: String, passwd: String, name: String) {
        self.user = user
        self.p2pAccount = p2pAccount
        self.isHttps = isHttps
        self.p2pMappingIndex = p2pMappingIndex
        self.p2pPassword = p2pPassword
        self.p2pSid = p2pSid
        self.port = port
        self.p2pUid = p2pUid
        self.hostAddress = hostAddress
        self.passwd = passwd
        self.name = name
    }
}
