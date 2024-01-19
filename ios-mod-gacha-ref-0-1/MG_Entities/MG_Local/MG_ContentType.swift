//
//  MG_ContentType.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 16.01.2024.
//

import Foundation

enum MG_ContentType: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case miniGames_mgn = "Mini-games_in_Gacha_LIfe"
    case collections_mgn = "Collections"
    case mods_mgn = "Mods"
    case characters_mgn = "Characters"
    case wallpapers_mgn = "Wallpapers"
    case editor_mgn = "Editor"
    case outfitIdeas_mgn = "Outfits_ideas"

    static var apiMenus: [MG_ContentType] = [.miniGames_mgn, .collections_mgn, .mods_mgn, .characters_mgn, .wallpapers_mgn, .editor_mgn, outfitIdeas_mgn]
    static var favoriteMenus: [MG_ContentType] = [.mods_mgn, .collections_mgn, .wallpapers_mgn, .miniGames_mgn, characters_mgn]

    // paths to json file
    var downloadPath: String {
        switch self {
        case .miniGames_mgn: return "/Mini-games_in_Gacha_LIfe.json"
        case .collections_mgn: return "/Collections.json"
        case .mods_mgn: return "/Mods.json"
        case .characters_mgn: return "/Characters.json"
        case .wallpapers_mgn: return "/Wallpapers.json"
        case .editor_mgn: return "/Editor.json"
        case .outfitIdeas_mgn: return "/Outfits_ideas.json"
        default:
            return ""
        }
    }

//    var folderName: String {
//        switch self{
//        case .mods_mgn :
//            return "Mods"
//        case .skins:
//            return "Skins"
//        case .tanks:
//            return "Tanks"
//        case .buildings:
//            return "Buildings"
//        default: return ""
//        }
//    }

//    var image: ImageResource{
//        switch self {
//        case .mods:
//            return .iconMenuMods
//        case .skins:
//            return .iconMenuSkins
//        case .tanks:
//            return .iconMenuTanks
//        case .buildings:
//            return .iconMenuBuilds
//        case .editor:
//            return .iconMenuEditors
//        case .myWorks:
//            return .iconMenuMyWorks
//        case .favorites:
//            return .iconMenuFavorites
//        case .settings:
//            return .iconMenuSettings
//        case .category:
//            return .iconMenuMods
//        }
//    }

//    var mainKey: String {
//        switch self {
//        case .mods_mgn:
//            return MG_ModsJsonKeys.main
//        case .characters_mgn:
//            return MG_CharactersJsonKeys.main
//        case .collections_mgn:
//            return MG_CollectionsJsonKeys.main
//        case .editor_mgn:
//            return MG_EditorJsonKeys.main
//        case .category:
//            return MG_CategoriesJsonKeys.main
//        case .editor:
//            return MG_EditorJsonKeys.main
//        default:
//            return ""
//        }
//    }

//    var entityName: String {
//        switch self {
//        case .mods:
//            return "ModsMO"
//        case .skins:
//            return "SkinsMO"
//        case .tanks:
//            return "TanksMO"
//        case .buildings:
//            return "BuildingsMO"
//        case .category:
//            return "CategoriesMO"
//        case .editor:
//            return "EditorMO"
//        default:
//            return ""
//        }
//    }
}

