//
//  MG_FlowView.swift
//  mods-for-melon-playground-42
//
//  Created by Дима Губеня on 23.12.2023.
//

import SwiftUI
import Resolver
import FlowStacks

struct MG_FlowView: View {
    
    @InjectedObject private var navigationStore: MG_MainNavigationStore

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        Router($navigationStore.routes) { $screen, _ in
            MG_pushContent(with: $screen)
                .hideNavBar(with: true)
        }
    }

    var tabView: some View {
        MG_ZStackWithBackground {
            TabView(selection: $navigationStore.selectedTab) {
                ForEach(MG_ContentType.sideMenu) { type in
                    switch navigationStore.selectedTab {
                    case .mods:
                        MG_GeneralContentView(selectedMenu: .mods)
                    case .skins:
                        MG_GeneralContentView(selectedMenu: .skins)
                    case .tanks:
                        MG_GeneralContentView(selectedMenu: .tanks)
                    case .buildings:
                        MG_GeneralContentView(selectedMenu: .buildings)
                    case .editor:
                        EmptyView()
                        //                MG_EditorListView(selectedMenu: .editor)
                    case .myWorks:
                        EmptyView()
                        //                MG_MyWorksView(selectedMenu: .myWorks)
                    case .favorites:
                        EmptyView()
                        //                MG_FavoriteView(selectedMenu: .favorites)
                    case .settings:
                        EmptyView()
                        //                MG_SettingsView()
                    default:
                        EmptyView()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disableTabViewSwipe()
            .edgesIgnoringSafeArea(.bottom)

            MG_SideMenu(
                isShowing: $navigationStore.presentSideMenu,
                content: AnyView(MG_SideMenuView(selectedSideMenuTab: $navigationStore.selectedTab, presentSideMenu: $navigationStore.presentSideMenu))
            )
        }
    }

    @ViewBuilder
    func MG_pushContent(with path: Binding<MG_MainRoute>) -> some View {
        switch path.wrappedValue {
        case .tabView:
            tabView
        case let .detail(item, contentType):
            EmptyView()
//            MG_GeneralDetailView(item: item, contentType: contentType)
        case .editor(let MG_MyWorks):
            EmptyView()
//            MG_EditorView(myMod: MG_MyWorks)
        }
    }
}

extension MG_View {
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
    MG_FlowView()
}
