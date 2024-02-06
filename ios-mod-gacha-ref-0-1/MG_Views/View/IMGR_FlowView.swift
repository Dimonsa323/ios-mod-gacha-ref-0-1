//
//  IMGR_FlowView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.02.2024.
//

import SwiftUI
import Resolver
import FlowStacks

struct IMGR_FlowView: View {
    
    @InjectedObject private var navigationStore: IMGR_MainNavigationStore

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        Router($navigationStore.routes) { $screen, _ in
            IMGR_pushContent(with: $screen)
                .hideNavBar(with: true)
        }
    }

    var tabView: some View {
        IMGR_ZStackWithBackground {
            TabView(selection: $navigationStore.selectedTab) {
                ForEach(IMGR_ContentType.sideMenu) { type in
                    switch navigationStore.selectedTab {
                    case .mods:
                        IMGR_GeneralContentView(selectedMenu: .mods)
                    case .skins:
                        IMGR_GeneralContentView(selectedMenu: .skins)
                    case .tanks:
                        IMGR_GeneralContentView(selectedMenu: .tanks)
                    case .buildings:
                        IMGR_GeneralContentView(selectedMenu: .buildings)
                    case .editor:
                        EmptyView()
                        //                IMGR_EditorListView(selectedMenu: .editor)
                    case .myWorks:
                        EmptyView()
                        //                IMGR_MyWorksView(selectedMenu: .myWorks)
                    case .favorites:
                        EmptyView()
                        //                IMGR_FavoriteView(selectedMenu: .favorites)
                    case .settings:
                        EmptyView()
                        //                IMGR_SettingsView()
                    default:
                        EmptyView()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disableTabViewSwipe()
            .edgesIgnoringSafeArea(.bottom)

            IMGR_SideMenu(
                isShowing: $navigationStore.presentSideMenu,
                content: AnyView(IMGR_SideMenuView(selectedSideMenuTab: $navigationStore.selectedTab, presentSideMenu: $navigationStore.presentSideMenu))
            )
        }
    }

    @ViewBuilder
    func IMGR_pushContent(with path: Binding<IMGR_MainRoute>) -> some View {
        switch path.wrappedValue {
        case .tabView:
            tabView
        case let .detail(item, contentType):
            EmptyView()
//            IMGR_GeneralDetailView(item: item, contentType: contentType)
        case .editor(let IMGR_MyWorks):
            EmptyView()
//            IMGR_EditorView(myMod: IMGR_MyWorks)
        }
    }
}

extension IMGR_View {
    @ViewBuilder
    func hideNavBar(with isHidden: Bool) -> some View {
        if #available(iOS 16.0, *) {
            self
                .toolbar(.hidden, for: .navigationBar)
        } else {
            self.navigationBarHidden(true)
        }
    }
}

#Preview {
    IMGR_FlowView()
}
