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
    public static var mySDK: Bundle {
        return Bundle(for: iHubLanguageManager.self)
    }
    private static var bundles: [String: Bundle] = [:]
    
    public class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.mySDK, AnyLanguageBundle.self)
        }
        
        guard let path = Bundle.mySDK.path(forResource: language, ofType: "lproj"),
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
    
    public static func printBundleInfo() {
        let bundle = Bundle(for: iHubLanguageManager.self)
        print("Bundle:", bundle)
        print("Bundle URL:", bundle.bundleURL)
        print("Resource URL:", bundle.resourceURL as Any)
        print("Localizations:", bundle.localizations)
        
        // 列出所有資源
        if let resourcePath = bundle.resourcePath {
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                print("Resources:", contents)
            } catch {
                print("Error listing resources:", error)
            }
        }
    }
    
    public static func checkLocalizationFiles() {
        let bundle = Bundle(for: iHubLanguageManager.self)
        
        print("Available Localizations:", bundle.localizations)
        print("Preferred Localizations:", bundle.preferredLocalizations)
        
        // 檢查特定語言
        for language in ["en", "zh-Hant"] {
            if let path = bundle.path(forResource: language, ofType: "lproj") {
                print("\(language) path found:", path)
            } else {
                print("\(language) path not found")
            }
        }
    }
    public static func debugBundles() {
        // 1. 檢查主 bundle
        let mainBundle = Bundle(for: iHubLanguageManager.self)
        print("=== Main Bundle ===")
        print("Path:", mainBundle.bundlePath)
        
        // 2. 檢查資源目錄
        if let resourcePath = mainBundle.resourcePath {
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                print("Resource contents:", contents)
                
                // 3. 如果找到 iHubSDK.bundle，檢查其內容
                if let bundlePath = mainBundle.path(forResource: "iHubSDK", ofType: "bundle") {
                    print("\n=== iHubSDK.bundle ===")
                    print("Bundle path:", bundlePath)
                    
                    let bundleContents = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
                    print("Bundle contents:", bundleContents)
                    
                    // 4. 檢查本地化文件
                    for language in ["en", "zh-Hant"] {
                        if let lprojPath = Bundle(path: bundlePath)?.path(forResource: language, ofType: "lproj") {
                            print("\(language).lproj found at:", lprojPath)
                            
                            // 檢查 .lproj 內容
                            let lprojContents = try FileManager.default.contentsOfDirectory(atPath: lprojPath)
                            print("\(language).lproj contents:", lprojContents)
                        }
                    }
                }
            } catch {
                print("Error:", error)
            }
        }
    }
}
