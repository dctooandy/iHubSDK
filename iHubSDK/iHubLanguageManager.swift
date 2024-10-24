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
