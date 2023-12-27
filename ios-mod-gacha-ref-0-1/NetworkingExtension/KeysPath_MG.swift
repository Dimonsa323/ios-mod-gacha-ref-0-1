//
//  KeysPath_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation

struct Keys_MG {
    
    enum Path_MG: String {
        case miniGames_mgn = "Mini-games_in_Gacha_LIfe",
             collections_mgn = "Collections",
             mods_mgn = "Mods",
             characters_mgn = "Characters",
             wallpapers_mgn = "Wallpapers",
             editor_mgn = "Editor",
             outfitIdeas_mgn = "Outfits_ideas"
             
        
        var contentPath: String {
            .init(format: "/%@.json", rawValue, rawValue)
        }
    }
    
    enum App_MGN: String {
        case accessCode_MG = "jCvna9SjDZsAAAAAAAABIBZXcKYTSKqzJPVqD7kAiyg",
             link_MG = "https://api.dropboxapi.com/oauth2/token",
             secret_MG = "qoflsocdbljjrhd",
             key_MG = "2v96y5lpjzq34h3"
    }
}

