//
//  iHubLanguageManager.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/23.
//

import UIKit

public class iHubLanguageManager {
    public static let shared = iHubLanguageManager()
    public var onUpdateLanguageFlow: (() -> Void)?
    public var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.languageCode ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "AppLanguage")
            updateLanguage(to: newValue)
        }
    }
    
    public static func version() -> String {
        guard let version = Bundle.mySDK.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "Unknown"
        }
        return version
    }
    
    private init() {}
    
    func updateLanguage(to languageCode: String) {
            // 1. 更新 UserDefaults
        UserDefaults.standard.set(languageCode, forKey: "AppLanguage")
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        
            // 2. 更新 app 的語言
        Bundle.setLanguage(languageCode)
      
            // 3. 發送通知
        NotificationCenter.default.post(name: Notification.Name("LanguageChanged"), object: nil)
        print("SDK設定Language")
            // 4. 重新設置根視圖控制器以應用更改
        DispatchQueue.main.async {
            self.onUpdateLanguageFlow?()
        }
    }
}

extension Bundle {
    static var mySDK: Bundle {
        return Bundle(for: iHubLanguageManager.self)
    }
    private static var bundles: [String: Bundle] = [:]
    
    public class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }
        
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return
        }
        
        bundles[language] = bundle
    }
    
    class AnyLanguageBundle: Bundle, @unchecked Sendable {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            if let bundle = Bundle.bundles[iHubLanguageManager.shared.currentLanguage] {
                return bundle.localizedString(forKey: key, value: value, table: tableName)
            }
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
