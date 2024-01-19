//
//  MG_Entities.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 14.01.2024.
//

import UIKit

protocol CellConfigurable_MGN {
    func configureCell_MGN(_ cell: UICollectionViewCell,
                           isFavorites: Bool,
                           update: (() -> Void)?,
                           action: (() -> Void)?)
}

protocol ModelProtocol_MGN: CellConfigurable_MGN, Codable, Hashable {
    static var type: MG_ContentType { get }
    var favId: String { get }
    var searchText: String? { get }
    var new: Bool { get }
    var top: Bool { get }
}

struct ModsResponseCodable_MG: Codable {
    let list: [Mods_MG]
    
    enum CodingKeys_MGN: String, CodingKey {
        case list = "category_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.list = try container.decode([Mods_MG].self, forKey: .list)
    }
}

struct Mods_MG: Codable /*ModelProtocol_MGN*/ {
    static let type: MG_ContentType = .mods_mgn
    let id: Int
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { name }
    
    enum CodingKeys_MGN: String, CodingKey {
        case id = "fg_45j", name = "23_esq", image = "391_xz", description = "lqp_1k",
             new = "new", top = "Top", filePath = "gdf_d3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.description = try container.decode(String.self, forKey: .description)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
        self.filePath = try container.decode(String.self, forKey: .filePath)
    }
}

struct WallpapersResponseCodable_MG: Codable {
    let response: WallpapersListCodable_MG
    
    enum CodingKeys_MGN: String, CodingKey {
        case response = "gkn_2a_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.response = try container.decode(WallpapersListCodable_MG.self, forKey: .response)
    }
}

struct WallpapersListCodable_MG: Codable {
    let list: [Wallpaper_MG]
    
    enum CodingKeys_MGN: String, CodingKey {
        case list = "gkn_2a_azil"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.list = try container.decode([Wallpaper_MG].self, forKey: .list)
    }
}

struct Wallpaper_MG: Codable /*ModelProtocol_MGN*/ {
    static let type: MG_ContentType = .wallpapers_mgn
    let newWall: String
    let id: String
    let image: String
    var new: Bool { Bool(newWall) ?? false }
    let top: Bool = false
    
    var favId: String { id }
    var searchText: String? { nil }
    
    enum CodingKeys_MGN: String, CodingKey {
        case newWall = "new", image = "gkn_2at4", id = "gkn_2af2"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.newWall = try container.decode(String.self, forKey: .newWall)
        self.image = try container.decode(String.self, forKey: .image)
    }
}

struct MiniGamesResponseCodable_MG: Codable {
    let list: [MiniGame_MG]
    
    enum CodingKeys_MGN: String, CodingKey {
        case list = "Mini-games in Gacha Life"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.list = try container.decode([MiniGame_MG].self, forKey: .list)
    }
}

struct MiniGame_MG: Codable /*ModelProtocol_MGN*/ {
    static let type: MG_ContentType = .miniGames_mgn
    let id: Int
    let name: String
    let gameplay: String
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { name }
    
    enum CodingKeys_MGN: String, CodingKey {
        case id = "hgk_23", new = "New", name = "dek4_s", image = "56fh-s",
             gameplay = "65gh-s", top = "Top"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.gameplay = try container.decode(String.self, forKey: .gameplay)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
    }
}

struct CharactersResponseCodable_MG: Codable {
    let list: [Character_MG]
    
    enum CodingKeys_MGN: String, CodingKey {
        case list = "category_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.list = try container.decode([Character_MG].self, forKey: .list)
    }
}

struct Character_MG: Codable /*ModelProtocol_MGN*/ {
    static let type: MG_ContentType = .characters_mgn
    let id: Int
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { nil }
    
    enum CodingKeys_MGN: String, CodingKey {
        case id = "fhg4_4", image = "gh43_s", new = "New", top = "Top"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
    }
}

struct OutfitIdeasResponseCodable_MG: Codable {
    let response: OutfitIdeasListCodable_MG
    
    enum CodingKeys_MGN: String, CodingKey {
        case response = "gh_34s_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.response = try container.decode(OutfitIdeasListCodable_MG.self, forKey: .response)
    }
}

struct OutfitIdeasListCodable_MG: Codable {
    let list: [OutfitIdea_MG]
    
    enum CodingKeys_MGN: String, CodingKey {
        case list = "gh_34s_azil"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.list = try container.decode([OutfitIdea_MG].self, forKey: .list)
    }
}

struct OutfitIdea_MG: Codable /*ModelProtocol_MGN*/ {
    static let type: MG_ContentType = .outfitIdeas_mgn
    let id: String
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { nil }
    
    enum CodingKeys_MGN: String, CodingKey {
        case id = "gh_34sf2", image = "gh_34st4", new = "New", top = "Top"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
    }
}

struct CollectionsResponseCodable_MG: Codable {
    let response: CollectionsListCodable_MG
    
    enum CodingKeys_MGN: String, CodingKey {
        case response = "75n_2a_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.response = try container.decode(CollectionsListCodable_MG.self, forKey: .response)
    }
}

struct CollectionsListCodable_MG: Codable {
    let list: [Collections_MG]
    
    enum CodingKeys_MGN: String, CodingKey {
        case list = "75n_2a_azil"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.list = try container.decode([Collections_MG].self, forKey: .list)
    }
}

struct Collections_MG: Codable /*ModelProtocol_MGN*/ {
    static let type: MG_ContentType = .collections_mgn
    let id: String
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { nil }
    
    enum CodingKeys_MGN: String, CodingKey {
        case id = "gh5_ds", image = "gh67-2", new = "New", top = "Top"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
    }
}

//extension Mods_MG {
//    func configureCell_MGN(_ cell: UICollectionViewCell,
//                           isFavorites: Bool,
//                           update: (() -> Void)?,
//                           action: (() -> Void)?) {
//        if let cell = cell as? ModsCell_MG {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update, action: action)
//        } else if let cell = cell as? ModsPadCell_MG {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update, action: action)
//        }
//    }
//}
//
//extension MiniGame_MG {
//    func configureCell_MGN(_ cell: UICollectionViewCell,
//                           isFavorites: Bool,
//                           update: (() -> Void)?,
//                           action: (() -> Void)?) {
//        if let cell = cell as? ModsCell_MG {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update, action: action)
//        } else if let cell = cell as? ModsPadCell_MG {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update, action: action)
//        }
//    }
//}
//
//extension Wallpaper_MG {
//    func configureCell_MGN(_ cell: UICollectionViewCell,
//                           isFavorites: Bool,
//                           update: (() -> Void)?,
//                           action: (() -> Void)?) {
//        if let cell = cell as? WallpaperCell_MG {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update)
//        }
//    }
//}
//
//extension Character_MG {
//    func configureCell_MGN(_ cell: UICollectionViewCell,
//                           isFavorites: Bool,
//                           update: (() -> Void)?,
//                           action: (() -> Void)?) {
//        if let cell = cell as? ContentCell {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update)
//        }
//    }
//}
//
//extension OutfitIdea_MG {
//    func configureCell_MGN(_ cell: UICollectionViewCell,
//                       isFavorites: Bool,
//                       update: (() -> Void)?,
//                       action: (() -> Void)?) {
//        if let cell = cell as? ContentCell {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update)
//        }
//    }
//}
//
//extension Collections_MG {
//    func configureCell_MGN(_ cell: UICollectionViewCell,
//                       isFavorites: Bool,
//                       update: (() -> Void)?,
//                       action: (() -> Void)?) {
//        if let cell = cell as? ContentCell {
//            cell.configure_MGN(with: self, isFavorites: isFavorites, update: update)
//        }
//    }
//}



//struct ModsResponseCodable_MG: Codable {
//    let list: [Mods_MG]
//    
//    enum CodingKeys_MGN: String, CodingKey {
//        case list = "category_list"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
//        self.list = try container.decode([Mods_MG].self, forKey: .list)
//    }
//}
//
//struct Mods_MG: Codable /*ModelProtocol_MGN*/ {
//  //  static let type: ContentType_MG = .mods_mgn
//    let id: Int
//    let name: String
//    let image: String
//    let description: String
//    let filePath: String
//    let new: Bool
//    let top: Bool
//    
//    var favId: String { String(id) }
//    var searchText: String? { name }
//    
//    enum CodingKeys_MGN: String, CodingKey {
//        case id = "fg_45j", name = "23_esq", image = "391_xz", description = "lqp_1k",
//             new = "new", top = "Top", filePath = "gdf_d3"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys_MGN.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.new = try container.decode(Bool.self, forKey: .new)
//        self.top = try container.decode(Bool.self, forKey: .top)
//        self.filePath = try container.decode(String.self, forKey: .filePath)
//    }
//}
