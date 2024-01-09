//
//  HomeView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 29.12.2023.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: TabBar = .home
    
    enum TabBar {
        case home
        case characters
        case games
        case settings
    }
    
    init() {
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
