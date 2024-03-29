//
//  TabBarAppearanceMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 02.01.2024.
//

import Foundation
import UIKit

struct TabBarAppearance {
    
    static var shared = TabBarAppearance()
    
    func setAppearance() {
        UITabBar.appearance().backgroundColor = UIColor(named: "secondary1")
        UITabBar.appearance().unselectedItemTintColor = .tabBarUnselected.withAlphaComponent(0.5)
        UITabBar.appearance().layer.opacity = 0.5
        UITabBar.appearance().tintColor = UIColor(named: "secondary1")
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.MG_fontWithName(.comfortaa, style: .medium,
                                                                 size: isIPad ? 24 : 12)], for: .normal
        )
    }
}
