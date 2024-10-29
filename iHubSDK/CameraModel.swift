//
//  CameraModel.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/29.
//
public struct CameraModel {
    public var key: String = ""
    public var type: String = ""
    public var ip: String = ""
    public var port: String = ""
    public var title: String = ""
    public var username: String = ""
    public var password: String = ""
    public var location: String = ""
    public var channel: String = ""
    public var bindGarageGroup: String = ""
    
    init(_ key: String? = nil, _ type: String? = nil, _ ip: String? = nil, _ port: String? = nil, _ title: String? = nil, _ username: String? = nil, _ password: String? = nil, _ location: String? = nil, _ channel: String? = nil, _ bindGarageGroup: String? = nil) {
        self.key = key ?? ""
        self.type = type ?? ""
        self.ip = ip ?? ""
        self.port = port ?? ""
        self.title = title ?? ""
        self.username = username ?? ""
        self.password = password ?? ""
        self.location = location ?? ""
        self.channel = channel ?? ""
        self.bindGarageGroup = bindGarageGroup ?? ""
    }
    
    init(_ obj: CameraObject) {
        self.key = obj.key
        self.type = obj.type
        self.ip = obj.ip
        self.port = obj.port
        self.title = obj.titleName
        self.username = obj.username
        self.password = obj.password
        self.location = obj.location
        self.channel = obj.channel
        self.bindGarageGroup = obj.bindGarageGroup
    }
}
