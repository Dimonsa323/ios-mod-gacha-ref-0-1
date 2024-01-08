//
//  HomeView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 29.12.2023.
//

import SwiftUI
import UIKit

struct TabBarView: View {
    @State private var selection: TabBar = .home
    
    enum TabBar {
        case home
        case characters
        case games
        case settings
    }
    
    init() {
     UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Comfortaa-Medium", size: 12)! ], for: .normal)
        
        TabBarAppearance.shared.setAppearance()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Label("Home", image: "tabBarHome")
                    }
                    .tag(TabBar.home)
                
                CharactersView()
                    .tabItem {
                        Label("Characters", image: "tabBarPerson")
                    }
                    .tag(TabBar.characters)
                
                GamesView()
                    .tabItem {
                        Label("Games", image: "tabBarGames")
                    }
                    .tag(TabBar.games)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", image: "tabBarSetting")
                            .font(.custom("Comfortaa-Medium", size: 12))
                    }
                    .tag(TabBar.settings)
            }
        }
//        .onAppear() {
//            TabBarAppearance.shared.setAppearance()
//        }
        .tint(.white)
    }
}

#Preview {
    TabBarView()
}
