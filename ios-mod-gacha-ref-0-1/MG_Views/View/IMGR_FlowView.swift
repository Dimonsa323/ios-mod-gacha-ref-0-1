//
//  IMGR_FlowView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.02.2024.
//

import SwiftUI
import Resolver
import FlowStacks

struct TTLS_FlowView: View {
    
    @InjectedObject private var navigationStore: TTLS_MainNavigationStore

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        Router($navigationStore.routes) { $screen, _ in
            TTLS_pushContent(with: $screen)
                .hideNavBar(with: true)
        }
    }

    var tabView: some View {
        TTLS_ZStackWithBackground {
            TabView(selection: $navigationStore.selectedTab) {
                ForEach(TTLS_ContentType.sideMenu) { type in
                    switch navigationStore.selectedTab {
                    case .mods:
                        TTLS_GeneralContentView(selectedMenu: .mods)
                    case .skins:
                        TTLS_GeneralContentView(selectedMenu: .skins)
                    case .tanks:
                        TTLS_GeneralContentView(selectedMenu: .tanks)
                    case .buildings:
                        TTLS_GeneralContentView(selectedMenu: .buildings)
                    case .editor:
                        EmptyView()
                        //                TTLS_EditorListView(selectedMenu: .editor)
                    case .myWorks:
                        EmptyView()
                        //                TTLS_MyWorksView(selectedMenu: .myWorks)
                    case .favorites:
                        EmptyView()
                        //                TTLS_FavoriteView(selectedMenu: .favorites)
                    case .settings:
                        EmptyView()
                        //                TTLS_SettingsView()
                    default:
                        EmptyView()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disableTabViewSwipe()
            .edgesIgnoringSafeArea(.bottom)

            TTLS_SideMenu(
                isShowing: $navigationStore.presentSideMenu,
                content: AnyView(TTLS_SideMenuView(selectedSideMenuTab: $navigationStore.selectedTab, presentSideMenu: $navigationStore.presentSideMenu))
            )
        }
    }

    @ViewBuilder
    func TTLS_pushContent(with path: Binding<TTLS_MainRoute>) -> some View {
        switch path.wrappedValue {
        case .tabView:
            tabView
        case let .detail(item, contentType):
            EmptyView()
//            TTLS_GeneralDetailView(item: item, contentType: contentType)
        case .editor(let TTLS_MyWorks):
            EmptyView()
//            TTLS_EditorView(myMod: TTLS_MyWorks)
        }
    }
}

extension TTLS_View {
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
    TTLS_FlowView()
}
