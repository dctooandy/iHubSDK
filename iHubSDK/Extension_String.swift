//
//  Extension_String.swift
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/24.
//

public extension String {
    
    func localized(comment: String = "") -> String {
        guard let bundle = Bundle.sdkBundle else {
            return self
        }
        let defaultLanguage = bundle.preferredLocalizations.first ?? "en"
        let language = UserDefaults.standard.string(forKey: "AppLanguage") ?? defaultLanguage
        
        guard
            let path = bundle.path(forResource: language, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(self, comment: comment)
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: comment)
    }
    
    func localized(with variables: [CVarArg]) -> String {
        guard let bundle = Bundle.sdkBundle else {
            return self
        }
        let defaultLanguage = bundle.preferredLocalizations.first ?? "en"
        let language = UserDefaults.standard.string(forKey: "AppLanguage") ?? defaultLanguage
        
        guard
            let path = bundle.path(forResource: language, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return String(format: NSLocalizedString(self, comment: ""), arguments: variables)
        }
        
        let localizedString = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        return String(format: localizedString, arguments: variables)
    }
}
