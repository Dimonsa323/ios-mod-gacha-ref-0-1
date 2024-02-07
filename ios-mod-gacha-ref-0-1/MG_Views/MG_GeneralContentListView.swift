//
//  GeneralContentListView.swift
//  mods-for-melon-playground-42
//
//  Created by Дима Губеня on 24.12.2023.
//

import SwiftUI
import Resolver
import FlowStacks
import Device

struct MG_GeneralContentListView<T: MG_ParentMO>: View {

    @Environment(\.MG_createSheet) private var MG_createSheet
    @EnvironmentObject var navigator: FlowNavigator<MG_MainRoute>
    @Injected private var coreDataStore: MG_CoreDataStore
    @Injected private var saveManager: MG_SaverManager
    @Injected private var networkManager: MG_NetworkMonitoringManager

    @State private var size: CGSize = .init()

    var searchText: String = ""
    let contentType: MG_ContentType
    var predicate: NSPredicate?
    var sortDescriptors: [NSSortDescriptor] = []
    var isFavourite: Bool = false

    let dropDownSelection: MG_DropDownSelection

    var body: some View {
        MG_DynamicFetchView(
            predicate: predicate,
            sortDescriptors: sortDescriptors
        ) { (mods: FetchedResults<T>) in
            VStack {
                if mods.isEmpty {
                    VStack(spacing: 0) {
                        if !searchText.isEmpty {
                            Text("NOT FOUND")
                        } else if isFavourite {
                            Text("EMPTY")
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .foregroundStyle(Color.white)
                    .MG_iosDeviceTypeFont(font: .init(name: .sfProDisplay, style: .regular, iPhoneSize: 20, iPadSize: 40))
                    .multilineTextAlignment(.center)
                    .ignoresSafeArea(.keyboard)
                } else {
                    gridView(data: mods)
                }
            }
        }
        .onReceive(saveManager.MG_didDownlaod, perform: presentDownloadSuccessPopUp)
    }

    func gridView(data: FetchedResults<T>) -> some View {
        return MG_CategoryList(data: data, numberOfColumns: gridItemCount, dropDownSelection: dropDownSelection) { item in
            MG_GeneralCardView(contentType: contentType, item: item) { action in
                switch action {
                case .favourite:
                    didTapToBookmark(item: item)
                case .pushDetail:
                    navigator.push(.detail(item, contentType))
                case .pushEditor(let data):
                    let myWork = MG_MyWorks(moc: coreDataStore.viewContext, item: item, imageData: data)
                    navigator.push(.editor(myWork))
                case .download(let rect):
                    Task {
                        await download(item: item)
                        await Task.MG_sleep(seconds: 1)
                        didTaspToShare(rect: rect, item: item)
                    }
                case .share(let rect):
                    didTaspToShare(rect: rect, item: item)
                }
            }
        }
    }
    
    private var gridItemCount: Int {
        switch contentType {
        case .skins, .buildings:
            isIPad ? (Device.size() < Size.screen12_9Inch ? 1 : 2) : 1
        default:
            isIPad ? 2 : 1
        }
    }
}

// MARK: - Methods
extension MG_GeneralContentListView {
    func didTapToBookmark(item: MG_ParentMO) {
        if item.isFavourite {
            MG_createSheet?(
                .init(
                    type: .removeFavoutire(contentType),
                    firstAction: { _ in
                        MG_createSheet?(nil)
                    },
                    secondAction: { _ in
                        item.isFavourite.toggle()
                        coreDataStore.MG_saveChanges()
                        MG_createSheet?(nil)
                    }
                )
            )
        } else {
            item.isFavourite.toggle()
            coreDataStore.MG_saveChanges()
        }
    }

    func download(item: MG_ParentMO) async {
        guard networkManager.MG_isReachable() else {
            return
        }
        MG_createSheet?(.init(type: .loading, firstAction: { _ in }, secondAction: {_ in }))
        let path = "\(contentType.folderName)/\(item.downloadPathOrEmpty)"
        await saveManager.MG_downloadDidTap(file: (path, item))
    }

    func didTaspToShare(rect: CGRect, item: MG_ParentMO) {
        saveManager.MG_shareApk(apkFileName: item.apkFileName, rect: rect)
    }

    func presentDownloadSuccessPopUp(result: Result<MG_SaveType, any Error>) {
        Task {
            switch result {
            case .success(let type):
                switch type {
                case .file(let item) :
                    item.isLoadedToPhone = true
                    coreDataStore.MG_saveChanges()

                    MG_createSheet?(.init(type: .saved, firstAction: { _ in }, secondAction: { _ in }))
                    await Task.MG_sleep(seconds: 1)
                    MG_createSheet?(nil)
                default:
                    break
                }

            case .failure:
                break
            }
        }
    }
}

#Preview {
    return MG_GeneralContentListView(searchText: "", contentType: .mods, dropDownSelection: .init())
        .environment(\.managedObjectContext, MG_CoreDataMockService.preview)
}

