//
//  ModsCD.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.01.2024.
//

import Foundation
import Foundation

struct IMGR_ModsModel: Codable {
    let id: Int
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool
    let apk: String
    
    enum CodingKeys_MGN: String, CodingKey {
        case id = "bjhiio0"
        case name = "ghitryi6"
        case image = "tgrh"
        case description = "yu86"
        case new = "new"
        case top = "top"
        case filePath = "gdf_d3"
        case apl = "adfi5_"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.description = try container.decode(String.self, forKey: .description)
        self.filePath = try container.decode(String.self, forKey: .filePath)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
        self.apk = try container.decode(String.self, forKey: .apk)
    }
}
