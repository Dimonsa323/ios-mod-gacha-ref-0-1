//
//  Font+ExtensionMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.12.2023.
//

import SwiftUI

typealias MG_UIFont = UIFont

extension MG_UIFont {
    
    enum MG_Style: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case regular = "-Regular"
    }
    
    enum MG_Name: String {
        case concert = "ConcertOne"
        case comfortaa = "Comfortaa"
    }
    
    static func MG_fontWithName(_ name: MG_Name, style: MG_Style, size: CGFloat) -> UIFont {
        let compoundName = "\(name.rawValue)\(style.rawValue)"
        
        return UIFont(name: compoundName, size: size)!
    }
    
}

typealias MG_Font = Font

extension MG_Font {
    static func MG_fontWithName(_ name: MG_UIFont.MG_Style, style: MG_UIFont.MG_Style, size: CGFloat) -> Font {
        let compoundName = "\(name.rawValue)\(style.rawValue)"
        
        return .custom(compoundName, size: size)
    }
}

struct MG_FontModel {
    let name: MG_UIFont.MG_Name
    let style: MG_UIFont.MG_Style
    let iPhoneSize: CGFloat
    let iPadSize: CGFloat
}
