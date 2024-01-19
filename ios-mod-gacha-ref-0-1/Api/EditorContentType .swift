//
//  EditorContentType .swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 19.01.2024.
//

import Foundation

enum MG_EditorContentType: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case living = "Living Templates"
    case miscTemplate = "Misc Templates"
    case MG_MyWorks = "My works"

    static var dropDownMenu: [MG_EditorContentType] = [.miscTemplate, .living]
}

