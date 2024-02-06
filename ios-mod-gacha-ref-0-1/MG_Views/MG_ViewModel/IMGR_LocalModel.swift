//
//  LocalModel.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.02.2024.
//

import Foundation

struct TTLS_LocalModel {
    var title: String?
    var description: String?
    var imagePath: String?
    var downloadPath: String?
    var category: String?
    var contentType: TTLS_EditorContentType?
    
    init(modsObject: [String: Any], category: String?) {
        title = modsObject[TTLS_ModsJsonKeys.title] as? String
        description = modsObject[TTLS_ModsJsonKeys.description] as? String
        imagePath = modsObject[TTLS_ModsJsonKeys.imagePath] as? String
        downloadPath = modsObject[TTLS_ModsJsonKeys.downloadPath] as? String
        self.category = category
    }
    
    init(tanksObject: [String: Any], category: String?) {
        title = tanksObject[TTLS_TanksJsonKeys.title] as? String
        description = tanksObject[TTLS_TanksJsonKeys.description] as? String
        imagePath = tanksObject[TTLS_TanksJsonKeys.imagePath] as? String
        downloadPath = tanksObject[TTLS_TanksJsonKeys.downloadPath] as? String
        self.category = category
    }
    
    init(categoriesObject: [String: Any]) {
        title = categoriesObject[TTLS_CategoriesJsonKeys.title] as? String
        imagePath = categoriesObject[TTLS_CategoriesJsonKeys.imagePath] as? String
    }
    
    init(editorObject: [String: Any], contentType: TTLS_EditorContentType) {
        imagePath = editorObject[TTLS_EditorJsonKeys.imagePath] as? String
        self.contentType = contentType
    }
    
    init(buildingsObject: [String: Any]) {
        title = buildingsObject[TTLS_BuildingsJsonKeys.title] as? String
        description = buildingsObject[TTLS_BuildingsJsonKeys.description] as? String
        imagePath = buildingsObject[TTLS_BuildingsJsonKeys.imagePath] as? String
        downloadPath = buildingsObject[TTLS_BuildingsJsonKeys.downloadPath] as? String
    }

    init(skinObject: [String: Any]) {
        title = skinObject[TTLS_SkinsJsonKeys.title] as? String
        description = skinObject[TTLS_SkinsJsonKeys.description] as? String
        imagePath = skinObject[TTLS_SkinsJsonKeys.imagePath] as? String
        downloadPath = skinObject[TTLS_SkinsJsonKeys.downloadPath] as? String
    }
}

