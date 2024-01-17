//
//  MG_Entities.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 14.01.2024.
//

import Foundation

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
  //  static let type: ContentType_MG = .mods_mgn
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
