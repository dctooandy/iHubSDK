//
//  CameraDeviceInfoModel.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/29.
//

import Foundation
struct CameraDeviceInfoModel {
    var user: String = ""
    var p2pAccount: String = ""
    var isHttps: String = ""
    var p2pMappingIndex: String = ""
    var p2pPassword: String = ""
    var p2pSid: String = ""
    var port: String = ""
    var p2pUid: String = ""
    var hostAddress: String = ""
    var passwd: String = ""
    var name: String = ""
    
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
