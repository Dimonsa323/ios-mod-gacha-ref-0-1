//
//  MG_Optional_Extension.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 16.01.2024.
//

import Foundation

typealias MG_Optional = Optional

protocol MG_AnyOptional {
    var isNil: Bool { get }
}

extension MG_Optional: MG_AnyOptional {
    var isNil: Bool { self == nil }
}

extension MG_Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

