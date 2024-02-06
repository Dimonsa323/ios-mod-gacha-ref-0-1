//
//  LocalModel.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.02.2024.
//

import Foundation

struct IMGR_LocalModel {
    var title: String?
    var description: String?
    var imagePath: String?
    var downloadPath: String?
    var category: String?
    var contentType: IMGR_EditorContentType?
    
    init(modsObject: [String: Any], category: String?) {
        title = modsObject[IMGR_ModsJsonKeys.title] as? String
        description = modsObject[IMGR_ModsJsonKeys.description] as? String
        imagePath = modsObject[IMGR_ModsJsonKeys.imagePath] as? String
        downloadPath = modsObject[IMGR_ModsJsonKeys.downloadPath] as? String
        self.category = category
    }
    
    init(tanksObject: [String: Any], category: String?) {
        title = tanksObject[IMGR_TanksJsonKeys.title] as? String
        description = tanksObject[IMGR_TanksJsonKeys.description] as? String
        imagePath = tanksObject[IMGR_TanksJsonKeys.imagePath] as? String
        downloadPath = tanksObject[IMGR_TanksJsonKeys.downloadPath] as? String
        self.category = category
    }
    
    init(categoriesObject: [String: Any]) {
        title = categoriesObject[IMGR_CategoriesJsonKeys.title] as? String
        imagePath = categoriesObject[IMGR_CategoriesJsonKeys.imagePath] as? String
    }
    
    init(editorObject: [String: Any], contentType: IMGR_EditorContentType) {
        imagePath = editorObject[IMGR_EditorJsonKeys.imagePath] as? String
        self.contentType = contentType
    }
    
    init(buildingsObject: [String: Any]) {
        title = buildingsObject[IMGR_BuildingsJsonKeys.title] as? String
        description = buildingsObject[IMGR_BuildingsJsonKeys.description] as? String
        imagePath = buildingsObject[IMGR_BuildingsJsonKeys.imagePath] as? String
        downloadPath = buildingsObject[IMGR_BuildingsJsonKeys.downloadPath] as? String
    }

    init(skinObject: [String: Any]) {
        title = skinObject[IMGR_SkinsJsonKeys.title] as? String
        description = skinObject[IMGR_SkinsJsonKeys.description] as? String
        imagePath = skinObject[IMGR_SkinsJsonKeys.imagePath] as? String
        downloadPath = skinObject[IMGR_SkinsJsonKeys.downloadPath] as? String
    }
}

