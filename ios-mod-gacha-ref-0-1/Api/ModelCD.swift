//
//  ModelCD.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.01.2024.
//

import Foundation

struct IMGR_MiniGamesModel: Codable {
    let list: [IMGR_MiniGame]
    
    enum CodingKeys: String, CodingKey {
        case list = "jut_list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try container.decode([IMGR_MiniGame].self, forKey: .list)
    }
}

struct IMGR_MiniGame: Codable {
    let id: Int
    let name: String
    let gameplay: String
    let image: String
    let new: Bool
    let top: Bool
    
    enum IMGR_CodingKeys: String, CodingKey {
        case id = "bjhiio0"
        case new = "new"
        case name = "ghitryi6"
        case image = "tgrh"
        case gameplay = "yu86"
        case top = "top"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.gameplay = try container.decode(String.self, forKey: .gameplay)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
    }
}
