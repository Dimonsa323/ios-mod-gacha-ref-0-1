//
//  KeysPathMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation

struct KeysMG_ {
    
    enum PathMG_: String {
        case miniGamesMG_n = "Mini-games_in_Gacha_LIfe",
             collectionsMG_n = "Collections",
             modsMG_n = "Mods",
             charactersMG_n = "Characters",
             wallpapersMG_n = "Wallpapers",
             editorMG_n = "Editor",
             outfitIdeasMG_n = "Outfits_ideas"
             
        
        var contentPath: String {
            .init(format: "/%@.json", rawValue, rawValue)
        }
    }
    
    enum AppMG_N: String {
        case accessCodeMG_ = "jCvna9SjDZsAAAAAAAABIBZXcKYTSKqzJPVqD7kAiyg",
             linkMG_ = "https://api.dropboxapi.com/oauth2/token",
             secretMG_ = "qoflsocdbljjrhd",
             keyMG_ = "2v96y5lpjzq34h3"
    }
}

