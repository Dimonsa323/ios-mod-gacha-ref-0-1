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
                        Label {
                            Text("Home")
                                .kerning(0.6)
                        } icon: {
                            Image(.tabBarHome)
                        }
                    }
                    .tag(TabBar.home)
                
                CharactersView()
                    .tabItem {
                        Label {
                            Text("Characters")
                        } icon: {
                            Image(.tabBarPerson)
                        }
                    }
                    .tag(TabBar.characters)
                
                GamesView()
                    .tabItem {
                        Label {
                            Text("Games")
                        } icon: {
                            Image(.tabBarGames)
                        }
                    }
                    .tag(TabBar.games)
                
                SettingsView()
                    .tabItem {
                        Label {
                            Text("Settings")
                        } icon: {
                            Image(.tabBarSetting)
                        }
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
