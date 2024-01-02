//
//  HomeView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 29.12.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var selection: TabBar = .home

    enum TabBar {
        case home
        case characters
        case Games
        case Settings
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                .tabItem {
                    Label("Home", image: "tabBarHome")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
