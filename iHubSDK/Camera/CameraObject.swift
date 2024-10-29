//
//  CameraObject.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/29.
//
import RealmSwift

class CameraObject: Object {
    @objc dynamic var key: String = ""
    @objc dynamic var type: String  = ""
    @objc dynamic var ip: String = ""
    @objc dynamic var port: String = ""
    @objc dynamic var titleName: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var channel: String = ""
    @objc dynamic var bindGarageGroup: String = ""
    
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
