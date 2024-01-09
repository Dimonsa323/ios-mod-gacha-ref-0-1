//
//  MG_DeviceFontModifier.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 07.01.2024.
//

import SwiftUI

extension MG_View {
    func MG_iosDeviceTypeFont(font: MG_FontModel) -> some View {
        
        return modifier(MG_DeviceFontModifier(font: font))
    }
}

struct MG_DeviceFontModifier: ViewModifier {
    let font: MG_FontModel
    
    var size: CGFloat {
        isIPad ? font.iPadSize : font.iPhoneSize
    }
    
    func body(content: Content) -> some View {
        let MG_compoundName = "\(font.name.rawValue)\(font.style.rawValue)"
        let _ = UIFont(name: MG_compoundName, size: size)!
        
        return content
            .font(.custom(MG_compoundName, size: size))
    }
}
