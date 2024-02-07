//
//  MainRoute_TTLS+DeepLink.swift
//  mods-for-melon-playgorund
//
//  Created by Дима Губеня on 11.12.2023.
//

import Foundation

enum IMGR_MainRoute: Hashable {
    case tabView
    case detail(IMGR_ParentMO, IMGR_ContentType)
    case editor(IMGR_MyWorks)
}
