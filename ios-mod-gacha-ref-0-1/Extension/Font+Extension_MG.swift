//
//  Font+Extension_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.12.2023.
//

import SwiftUI

enum FontType_MG: String {
    case concertOneRegular = "ConcertOne-Regular"
    case comfortaaBold = "Comfortaa-Bold"
    case comfortaaMedium = "Comfortaa-Medium"
    case comfortaaRegular = "Comfortaa-Regular"
}

extension Font {
    static func customFont(type: FontType_MG, size: CGFloat) -> Font {
        return Font.custom(type.rawValue, size: size) 
    }
}
