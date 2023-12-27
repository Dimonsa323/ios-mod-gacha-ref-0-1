//
//  Appearance.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import UIKit

final class AppAppearance_MGN {
    
    static func setupAppearance_MGN() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        let titleFontSize: CGFloat = deviceType == .phone ? 20 : 35
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.theme(.black),
            .font: UIFont(name: "BalooThambi-Regular", size: titleFontSize)!
        ]
    }
}


