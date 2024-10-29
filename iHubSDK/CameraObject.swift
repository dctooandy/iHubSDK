//
//  CameraObject.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/29.
//
import RealmSwift

class CameraObject: Object {
    @objc dynamic public var key: String = ""
    @objc dynamic public var type: String  = ""
    @objc dynamic public var ip: String = ""
    @objc dynamic public var port: String = ""
    @objc dynamic public var titleName: String = ""
    @objc dynamic public var username: String = ""
    @objc dynamic public var password: String = ""
    @objc dynamic public var location: String = ""
    @objc dynamic public var channel: String = ""
    @objc dynamic public var bindGarageGroup: String = ""
    
    override class func primaryKey() -> String? {
        return "key"
    }
    
    init(key: String, type: String, ip: String, port: String, titleName: String = "", username: String, password: String, location: String = "", channel: String = "", bindGarageGroup: String = "") {
        self.key = key
        self.type = type
        self.ip = ip
        self.port = port
        self.titleName = titleName
        self.username = username
        self.password = password
        self.location = location
        self.channel = channel
        self.bindGarageGroup = bindGarageGroup
    }
    
    init(_ model: CameraModel) {
        self.key = model.key
        self.type = model.type
        self.ip = model.ip
        self.port = model.port
        self.titleName = model.title
        self.username = model.username
        self.password = model.password
        self.location = model.location
        self.channel = model.channel
        self.bindGarageGroup = model.bindGarageGroup
    }
    
    required override init() {
    }
}
