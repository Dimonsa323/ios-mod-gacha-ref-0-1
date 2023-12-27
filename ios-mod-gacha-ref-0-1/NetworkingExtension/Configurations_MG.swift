//
//  Configurations_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation
import CoreText

private var _MGN1245: String { "_MGN" }
private var _MGN12435: Int { 0 }

enum Configurations_MGN {
    static let subFontUrl_MGN = Bundle.main.url(forResource: "sub", withExtension: "ttf")!
    static let adjustToken_MGN = "hfg1t85ufqbk"
    
    static let pushwooshToken_MGN = "56F9A-A546D"
    static let pushwooshAppName_MGN = "test"
    
    static let termsLink_MGN: String = "https://www.google.com"
    static let policyLink_MGN: String = "https://www.google.com"
    
    
    enum Product_MGN: CaseIterable {
        case main
        case content1
        case content2
        case content3
        
        var id_MGN: String {
            switch self {
            case .content1: return "unlockOne"
            case .content2: return "unlockTwo"
            case .main:     return "main_sub"
            case .content3: return "unlockThree"
            }
        }
        var pushTag_MGN: String {
            switch self {
            case .content2: return "SecondSubscription"
            case .main:     return "MainSubscription"
            case .content3: return "FourSubscription"
            case .content1: return "SecondSubscription"
            }
        }
    }
    
    static let subscriptionSharedSecret_MGN = "253336a4821b43d0af174241a9a85f90"
    
    static func getSubFontName_MGN() -> String {
        let fontPath = Configurations_MGN.subFontUrl_MGN.path as CFString
        let fontURL = CFURLCreateWithFileSystemPath(nil, fontPath, CFURLPathStyle.cfurlposixPathStyle, false)
        
        guard let fontDataProvider = CGDataProvider(url: fontURL!) else {
            return ""
        }
        
        if let font = CGFont(fontDataProvider) {
            if let postScriptName = font.postScriptName as String? {
                return postScriptName
            }
        }
        return ""
    }
}

enum ConfigurationMediaSub_MGN {
    static let nameFileVideoForPhone = "phone"
    static let nameFileVideoForPad = "pad"
    static let videoFileType = "mp4"
}

