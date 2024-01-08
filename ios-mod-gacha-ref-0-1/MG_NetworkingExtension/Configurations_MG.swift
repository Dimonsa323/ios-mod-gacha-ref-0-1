//
//  ConfigurationsMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation
import CoreText

private var MG_N1245: String { "MG_N" }
private var MG_N12435: Int { 0 }

enum ConfigurationsMG_N {
    static let subFontUrlMG_N = Bundle.main.url(forResource: "sub", withExtension: "ttf")!
    static let adjustTokenMG_N = "hfg1t85ufqbk"
    
    static let pushwooshTokenMG_N = "56F9A-A546D"
    static let pushwooshAppNameMG_N = "test"
    
    static let termsLinkMG_N: String = "https://www.google.com"
    static let policyLinkMG_N: String = "https://www.google.com"
    
    
    enum ProductMG_N: CaseIterable {
        case main
        case content1
        case content2
        case content3
        
        var idMG_N: String {
            switch self {
            case .content1: return "unlockOne"
            case .content2: return "unlockTwo"
            case .main:     return "main_sub"
            case .content3: return "unlockThree"
            }
        }
        var pushTagMG_N: String {
            switch self {
            case .content2: return "SecondSubscription"
            case .main:     return "MainSubscription"
            case .content3: return "FourSubscription"
            case .content1: return "SecondSubscription"
            }
        }
    }
    
    static let subscriptionSharedSecretMG_N = "253336a4821b43d0af174241a9a85f90"
    
    static func getSubFontNameMG_N() -> String {
        let fontPath = ConfigurationsMG_N.subFontUrlMG_N.path as CFString
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

enum ConfigurationMediaSubMG_N {
    static let nameFileVideoForPhone = "phone"
    static let nameFileVideoForPad = "pad"
    static let videoFileType = "mp4"
}

