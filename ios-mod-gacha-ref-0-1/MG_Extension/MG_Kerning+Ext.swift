//
//  MG_Kerning+Ext.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 13.01.2024.
//

import Foundation
import UIKit

extension String {
    var withAddedSpacing: String {
        Array(self)
            .compactMap { String($0) }
            .joined(separator: "\u{2006}")
    }
}
