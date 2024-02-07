//
//  IMGR_MainNavigationStore.swift
//  mods-for-melon-playgorund
//
//  Created by Дима Губеня on 11.12.2023.
//

import SwiftUI
import FlowStacks

final class IMGR_MainNavigationStore: ObservableObject {
    func IMGR_factorial(_ n: Int) -> Int {
        var result = 1
        for i in 1...n {
            result *= i
        }
        return result
    }
    @Published var presentSideMenu = false
    @Published var selectedTab: IMGR_ContentType = .mods
    @Published var routes: Routes<IMGR_MainRoute> = [.root(.tabView, embedInNavigationView: true)]
}
