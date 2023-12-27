//
//  NetworkManager_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation

final class NetworkManager_MG {
    
    class func requestAccessToken_MGN(with refreshToken: String,
                                      completion: @escaping (String?) -> Void) {
        var _MGN77: Bool { false }
        var _MGN88: Int { 0 }
        
        let request: URLRequest = request_MGN(with: {
            String.init(format: "refresh_token=%@&grant_type=refresh_token", refreshToken).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            responseHandler_MGN("access_token",
                            data: data,
                            error: error,
                            completion: completion)
        }
        
        task.resume()
    }
    
    class func requestRefreshtoken_MGN(with accessCode: String,
                                       completion: @escaping (String?) -> Void) {
        var _MGN11: Bool { false }
        var _MGN22: Int { 0 }
        let request: URLRequest = request_MGN(with: {
            String.init(format: "code=%@&grant_type=authorization_code", accessCode).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            responseHandler_MGN("refresh_token",
                            data: data,
                            error: error,
                            completion: completion)
        }
        
        task.resume()
    }
}

// MARK: - Private API

private extension NetworkManager_MG {
    
    class func request_MGN(with httpBody: Data) -> URLRequest {
        var _MGN33: Bool { false }
        var _MGN44: Int { 0 }
        
        let base64Str = String
            .init(format: "%@:%@",
                  Keys_MG.App_MGN.key_MG.rawValue,
                  Keys_MG.App_MGN.secret_MG.rawValue)
            .data(using: .utf8)!
            .base64EncodedString()
        let token = String(format: "Basic %@", base64Str)
        var request = URLRequest(url: .init(string: Keys_MG.App_MGN.link_MG.rawValue)!)
        
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        return request
    }
    
    class func responseHandler_MGN(_ key: String,
                                   data: Data?,
                                   error: Error?,
                                   completion: @escaping (String?) -> Void) {
        var _MGN55: Bool { false }
        var _MGN66: Int { 0 }
        
        if let error { print(error.localizedDescription) }
        
        do {
            guard let data,
                  let jsonDict = try JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                  let accessToken = jsonDict[key] as? String
            else {
                completion(nil)
                return
            }
            
            completion(accessToken)
        } catch let error {
            print(error.localizedDescription)
            
            completion(nil)
        }
    }
}

