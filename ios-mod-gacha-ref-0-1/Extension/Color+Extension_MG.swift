//
//  Color+Extension_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.12.2023.
//

import SwiftUI

extension Color {
    enum ColorType_MG {
        case black
        case darkViolet
        case gray
        case light_black
        case mediumViolet
        case pink
        case red
        case secondary_1
        case softPeriwinkle
        case violet
        case white
        case lightViolet
        case textColor
        case whiteLight
        case search
        case tabBarUnselected
        case modsCellBackground
    }

    static func theme(_ colorType: ColorType_MG) -> Color {
        var color: Color?

        switch colorType {
        case .modsCellBackground:
            color = Color("modsCellBackground")
        case .tabBarUnselected:
            color = Color("tabBarUnselected")
        case .search:
            color = Color("search")
        case .whiteLight:
            color = Color("whiteLight")
        case .textColor:
            color = Color("textColor")
        case .lightViolet:
            color = Color("lightViolet")
        case .white:
            color = Color("white")
        case .black:
            color = Color("black")
        case .darkViolet:
            color = Color("darkViolet")
        case .gray:
            color = Color("gray")
        case .light_black:
            color = Color("light_black")
        case .mediumViolet:
            color = Color("mediumViolet")
        case .pink:
            color = Color("pink")
        case .softPeriwinkle:
            color = Color("softPeriwinkle")
        case .red:
            color = Color("red")
        case .secondary_1:
            color = Color("secondary1")
        case .violet:
            color = Color("violet")
        }
        // TODO: remove before project publish
        guard let color = color else {
            fatalError("Color \(colorType) not found")
        }

        return color
    }
}

