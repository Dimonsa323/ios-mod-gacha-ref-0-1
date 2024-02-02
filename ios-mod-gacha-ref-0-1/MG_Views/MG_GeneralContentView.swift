//
//  GeneralContentView.swift
//  mods-for-melon-playground-42
//
//  Created by Александр Ковалев on 23.12.2023.
//

import SwiftUI
import Resolver

struct MG_GeneralContentView: View {

    @Injected private var navigationStore: MG_MainNavigationStore
    @Injected private var coreDataStore: MG_CoreDataStore
    @Injected private var homApiManager: MG_HomeDataAPI

    @FetchRequest<MG_CategoriesMO>(fetchRequest: .MG_categories())
    private var categoriesMO

    @State private var selectedCategories: MG_DropDownSelection = .init(value: "")
    @State private var searchText: String = ""
    @State private var showSearchBar: Bool = false
    @State private var categories: [MG_DropDownSelection] = []

    @FocusState private var focusedField: MG_FocusField?

    let selectedMenu: MG_ContentType

    private var isNeedDropDown: Bool {
        !showSearchBar && (selectedMenu == .mods || selectedMenu == .tanks)
    }

    var body: some View {
        MG_ZStackWithBackground {
            VStack(spacing: 0) {
                navBar

                if isNeedDropDown {
                    MG_DropDown(
                        content: categories,
                        selection: $selectedCategories,
                        dynamic: false,
                        isNeedScroll: true
                    )
                    .zIndex(1001)
                    .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 20, iPadPadding: 40)
                }
                contentList
                Spacer(minLength: 0)
            }
            .blur(radius: navigationStore.presentSideMenu ? 5 : 0)
            .animation(.default, value: navigationStore.presentSideMenu)
            .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 20, iPadPadding: 85, iPadIsAspect: true)
        }
        .onDisappear {
            if !searchText.isEmpty {
                searchText = ""
                showSearchBar = false
            }
        }
        .MG_onViewDidLoad(action: {
            if !categoriesMO.isEmpty {
                categories = categoriesMO.map { MG_DropDownSelection(value: $0.titleOrEmpty) }
                if let category = categories.first {
                    selectedCategories = category
                }
            }
        })
        .onChange(of: focusedField) { state in
            if state.isNil, showSearchBar, searchText.isEmpty {
                withAnimation {
                    showSearchBar = false
                }
            }
        }
    }
}

// MARK: - Child Views
private extension MG_GeneralContentView {
    var navBar: some View {
        MG_CustomNavBar(text: showSearchBar ? "" : selectedMenu.rawValue) {
            HStack(spacing: 0) {
                if !showSearchBar {
                    MG_CircleButton(image: .iconBurger, bgColor: .white) {
                        navigationStore.presentSideMenu = true
                    }
                    .transition(.scale)
                    Spacer()
                }
                if selectedMenu == .mods || selectedMenu == .tanks {
                    MG_SearchBar(
                        showSearchBar: $showSearchBar,
                        searchText: $searchText,
                        focusedField: $focusedField
                    )
                }
            }
        }
    }

    @ViewBuilder
    var contentList: some View {
        switch selectedMenu {
        case .mods:
            MG_GeneralContentListView<MG_ModsMO>(
                searchText: searchText,
                contentType: .mods,
                predicate: MG_homePredicate(with: selectedCategories.value, searchText: searchText, searchActive: showSearchBar),
                sortDescriptors: [NSSortDescriptor(keyPath: \MG_CategoriesMO.title, ascending: true)],
                dropDownSelection: selectedCategories
            )
            .task {
                try? await homApiManager.MG_getModels(type: selectedMenu)
            }
            .onDisappear {
                searchText = ""
                showSearchBar = false
            }
        case .skins:
            MG_GeneralContentListView<MG_SkinsMO>(
                contentType: .skins,
                sortDescriptors: [NSSortDescriptor(keyPath: \MG_ParentMO.title, ascending: true)],
                dropDownSelection: selectedCategories
            )
            .task {
                try? await homApiManager.MG_getModels(type: selectedMenu)
            }
        case .tanks:
            MG_GeneralContentListView<MG_TanksMO>(
                searchText: searchText,
                contentType: .tanks,
                predicate: MG_homePredicate(with: selectedCategories.value, searchText: searchText, searchActive: showSearchBar),
                sortDescriptors: [NSSortDescriptor(keyPath: \MG_ParentMO.title, ascending: true)],
                dropDownSelection: selectedCategories
            )
            .task {
                try? await homApiManager.MG_getModels(type: selectedMenu)
            }
        case .buildings:
            MG_GeneralContentListView<MG_BuildingsMO>(
                contentType: .buildings,
                sortDescriptors: [NSSortDescriptor(keyPath: \MG_ParentMO.title, ascending: true)],
                dropDownSelection: selectedCategories
            )
            .task {
                try? await homApiManager.MG_getModels(type: selectedMenu)
            }
        default: EmptyView()
        }
    }

}

#Preview {
    MG_GeneralContentView(selectedMenu: .mods)
        .environment(\.managedObjectContext, MG_CoreDataMockService.preview)
}
