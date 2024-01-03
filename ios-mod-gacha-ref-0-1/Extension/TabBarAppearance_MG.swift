//
//  TabBarAppearance_MG.swift
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
        UITabBar.appearance().unselectedItemTintColor = .tabBarUnselected
        UITabBar.appearance().tintColor = UIColor(named: "secondary1")
    }
}
