//
//  MG_DropboxManager.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 16.01.2024.
//

import Foundation
import SwiftyDropbox
import DataCache
import HYSLogger
import SwiftUI

struct DropBoxKeys_MG {
    static let appkey = "xezpvlrhwl66auw"
    static let appSecret = "jepz1de5cja0p2o"
    static let authCode = "czHFetFkAxAAAAAAAAAEe9V-c1UbHehRdha32aY_hTw"
    static let apiLink = "https://api.dropboxapi.com/oauth2/token"
    static let refreshToken = "Xh3GkFRCv5kAAAAAAAAAATWGSiIzuCaa14Bac_C1d1pVpR8nx_QCySv6Scwquqfu"
}

final class MG_Dropbox : NSObject {

    public var client : DropboxClient?
    private let userDefaults = UserDefaults.standard

    func MG_init_Dropbox() {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        DropboxClientsManager.setupWithAppKey(DropBoxKeys_MG.appkey)

        Task {
            do {
                try await MG_getAuthorizedClient()
                Logger.debug("Success Authorized client")
            } catch {
                Logger.debug(error)
            }
        }
    }
//    private func MG_getRefreshToken() async {
//        do {
//            let refreshToken = try await MG_getReshreshToken(authCode: DropBoxKeys_MG.authCode)
//            let accessToken = try await MG_getAccessToken(refreshToken: refreshToken)
//            client = DropboxClient(accessToken: accessToken)
//            print("good job first open token 🫡 \(accessToken),\(String(describing: client))")
//        } catch {
//            Logger.error(error)
//        }
//    }
}

// MARK: - Async Await
extension MG_Dropbox {

    func MG_uploadJSONFile(filePath: String, from urlFrom: URL) async throws -> String? {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let client = try await MG_getAuthorizedClient()

        return try await MG_upload(client: client, filePath: filePath, from: urlFrom)
    }

    func MG_downloadModel<T: Codable>(filePath: String) async throws -> T {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let json = try await MG_downloadData(filePath: filePath)

        return try JSONDecoder().decode(T.self, from: json)
    }

    func MG_downloadData(filePath: String) async throws -> Data {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let client = try await MG_getAuthorizedClient()

        return try await MG_download(client: client, filePath: filePath)
    }

    func MG_removeFolder(_ filePath: String) async throws {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let client = try await MG_getAuthorizedClient()

        client.files.deleteV2(path: filePath)
    }

    // MARK: - File download link
    func MG_getFileDownloadLink(filePath: String) async throws -> URL? {

        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }

        let filePath = filePath.starts(with: "/") ? filePath : "/" + filePath
        let client = try await MG_getAuthorizedClient()

        return try await MG_getTemporaryLink(client: client, filePath: filePath)
    }

    func MG_getData(forPath path: String) async throws -> Data {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let path = path.starts(with: "/") ? path : "/" + path

        if let data = DataCache.instance.readData(forKey: path) {
           return data
        } else {
            let data = try await MG_downloadData(filePath: path)
            DataCache.instance.write(data: data, forKey: path)
            return data
        }
    }

    func MG_writeImageToCash(forPath path: String, image: UIImage) {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let path = path.starts(with: "/") ? path : "/" + path

        if DataCache.instance.readData(forKey: path).isNil {
            DataCache.instance.write(image: image, forKey: path)
        }
    }

    func MG_getImageFromCache(forPath path: String) -> UIImage? {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        return DataCache.instance.readImage(forKey: path)
    }

    func MG_getMetaData(type: MG_ContentType) async throws -> Bool {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        let client = try await MG_getAuthorizedClient()

        return try await MG_getMetaData(client: client, type: type)
    }
}

// MARK: - Convert sync to async
private extension MG_Dropbox {

    // MARK: - Temporary Link
    func MG_getTemporaryLink(client: DropboxClient, filePath: String) async throws -> URL? {
        try await withCheckedThrowingContinuation { continuation in
            self.MG_getTemporaryLink(client: client, filePath: filePath) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    func MG_getTemporaryLink(client: DropboxClient, filePath: String, completion: @escaping MG_ValueClosure<Result<URL?, Error>>) {
        client.files.getTemporaryLink(path: filePath).response { response, error in
            if let result = response {
                completion(.success(URL(string: result.link)))
            } else if let error = error {
                completion(.failure(MG_APIError.error("Error getting temporary link: \(error)")))
            }
        }
    }

    // MARK: - Download
    func MG_download(client: DropboxClient, filePath: String) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            self.MG_download(client: client, filePath: filePath) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    func MG_download(client: DropboxClient, filePath: String, completion: @escaping MG_ValueClosure<Result<Data, Error>>) {
        client.files.download(path: filePath).response { response, error in
            if let response {
                let data = response.1
//                Logger.debug_MG(data.prettyPrintedJSONString ?? "")
                completion(.success(data))
            } else if let error {
                completion(.failure(MG_APIError.error("Error downloading JSON file for path: \(filePath), \nerror: \(error)")))
            }
        }
    }

    // MARK: - Upload
    func MG_upload(client: DropboxClient, filePath: String, from urlFrom: URL) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            self.MG_upload(client: client, filePath: filePath, from: urlFrom) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    func MG_upload(client: DropboxClient, filePath: String, from urlFrom: URL, completion: @escaping MG_ValueClosure<Result<String,Error>>) {
        client.files.upload(path: filePath, mode: .overwrite, input: urlFrom).response { response, error in
            if let _ = response {
                return completion(.success("JSON file uploaded to Dropbox: \(filePath)"))
            } else if let error = error {
                return completion(.failure(MG_APIError.error(error.description)))
            }
        }
    }

    // MARK: - MetaData
    func MG_getMetaData(client: DropboxClient, type: MG_ContentType) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            self.MG_getMetaData(client: client, type: type) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }
    func MG_getMetaData(
        client: DropboxClient,
        type: MG_ContentType,
        completion: @escaping MG_ValueClosure<Result<Bool, Error>>
    ) {
        client.files.getMetadata(path: type.downloadPath).response(completionHandler: { data, error in
            if let data = data as? Files.FileMetadata {
                if data.size == self.userDefaults.integer(forKey: "bytes\(type.rawValue)") {
                    completion(.success(false))
                } else {
                    self.userDefaults.set(Int(data.size), forKey: "bytes\(type.rawValue)")
                    completion(.success(true))
                }
            } else if let error = error {
                completion(.failure(MG_APIError.checkUpdateError(type: type, errorDescription: error.description)))
            } else {
                completion(.failure(MG_APIError.error("unknownError")))
            }
        })
    }
}

// MARK: - Refresh & Access token & Authorize
private extension MG_Dropbox {
    func MG_getReshreshToken(authCode: String) async throws -> String {

        let username = DropBoxKeys_MG.appkey
        let password = DropBoxKeys_MG.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        let parameters : Data = "code=\(authCode)&grant_type=authorization_code".data(using: .utf8)!
        let url = URL(string: DropBoxKeys_MG.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters

        let (data, response) = try await URLSession.shared.data(for: apiRequest)

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw MG_APIError.unexpectedResponse
        }
        guard MG_HTTPCodes.success.contains(code) else {
            if let errorRespose = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
               let error = errorRespose["error_description"]
            {
                Logger.error(error)
                throw MG_APIError.error(error)
            }

            throw MG_APIError.unexpectedResponse
        }

        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

        if let responseJSON = responseJSON as? [String: Any], let token = responseJSON["refresh_token"] as? String {
            return token
        }

        throw MG_APIError.error("Access token error")
    }


    func MG_getAccessToken(refreshToken: String) async throws -> String {
        let username = DropBoxKeys_MG.appkey
        let password = DropBoxKeys_MG.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        let parameters : Data = "refresh_token=\(refreshToken)&grant_type=refresh_token".data(using: .utf8)!
        let url = URL(string: DropBoxKeys_MG.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters

        let (data, response) = try await URLSession.shared.data(for: apiRequest)

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw MG_APIError.unexpectedResponse
        }
        guard MG_HTTPCodes.success.contains(code) else {
            if let errorRespose = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
               let error = errorRespose["error_description"]
            {
                Logger.error(error)
                throw MG_APIError.error(error)
            }

            throw MG_APIError.unexpectedResponse
        }

        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])

        if let responseJSON = responseJSON as? [String: Any], let token = responseJSON["access_token"] as? String {
            return token
        }

        throw MG_APIError.error("Access token error")
    }

    @discardableResult
    func MG_getAuthorizedClient() async throws -> DropboxClient {
        if let client {
            return client
        } else {
            let accessToken = try await MG_getAccessToken(refreshToken: DropBoxKeys_MG.refreshToken)

            if let client = client {
                return client
            } else {
                let client = DropboxClient(accessToken: accessToken)
                self.client = client

                return client
            }
        }
    }
}

