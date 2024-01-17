//
//  MG_APIError.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 17.01.2024.
//

import Foundation

enum MG_APIError: Error {
    case checkUpdateError(type: MG_ContentType, errorDescription: String)
    case invalidURL
    case unexpectedResponse
    case noInternetConnection
    case qiblaWithoutLocation
    case parseError(MG_ContentType)
    case error(String)
}

extension MG_APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .noInternetConnection: return "Please check your internet connection and try again"
        case .qiblaWithoutLocation: return "Location permission is required in order to use Quibla Compass"
        case let .checkUpdateError(type, errorDescription): return "Update Error \(type) - \(errorDescription)"
        case .parseError(let type): return "Parse error \(type.rawValue)"
        case .error(let error): return error
        }
    }
}
