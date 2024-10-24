//
//  Extension+Bundle.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/24.
//

import Foundation
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
    
    class AnyLanguageBundle: Bundle {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            if let bundle = Bundle.bundles[iHubLanguageManager.shared.currentLanguage] {
                return bundle.localizedString(forKey: key, value: value, table: tableName)
            }
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
