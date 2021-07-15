//
//  AppConfigurations.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 14/07/2021.
//

import UIKit

enum Environment {
    case configuration
    case serverUrl
    case displayName
    case enableLog
    
    private var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    private var plistKey: String {
        switch self {
        case .configuration:
            return "Config"
        case .serverUrl:
            return "Server_Url"
        case .displayName:
            return  "CFBundleDisplayName"
        case .enableLog:
            return "Enable_Log"
        }
    }
    
    var value: String{
        return (infoDict[self.plistKey] as! String).replacingOccurrences(of: "\\", with: "")
    }
}
