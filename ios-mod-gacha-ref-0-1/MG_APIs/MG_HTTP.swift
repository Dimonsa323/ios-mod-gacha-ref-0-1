//
//  MG_HTTP.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 17.01.2024.
//

import Foundation
enum MG_HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

enum MG_HTTPHeadersKey: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case contentDisposition = "Content-Disposition"
    case contentLength = "Content-Length"
    case applicationId = "X-Parse-Application-Id"
    case restApiKey = "X-Parse-REST-API-Key"
}

typealias MG_HTTPCode = Int
typealias MG_HTTPCodes = Range<Int>
typealias MG_HTTPHeaders = [String: String]
typealias MG_Parameters = [String: Any]

extension MG_HTTPCodes {
    static let success = 200 ..< 300
}

