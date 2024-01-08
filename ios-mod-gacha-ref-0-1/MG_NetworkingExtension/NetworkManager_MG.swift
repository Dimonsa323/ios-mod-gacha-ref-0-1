//
//  NetworkManagerMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation

final class NetworkManagerMG_ {
    
    class func requestAccessTokenMG_N(with refreshToken: String,
                                      completion: @escaping (String?) -> Void) {
        var MG_N77: Bool { false }
        var MG_N88: Int { 0 }
        
        let request: URLRequest = requestMG_N(with: {
            String.init(format: "refresh_token=%@&grant_type=refresh_token", refreshToken).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            responseHandlerMG_N("access_token",
                            data: data,
                            error: error,
                            completion: completion)
        }
        
        task.resume()
    }
    
    class func requestRefreshtokenMG_N(with accessCode: String,
                                       completion: @escaping (String?) -> Void) {
        var MG_N11: Bool { false }
        var MG_N22: Int { 0 }
        let request: URLRequest = requestMG_N(with: {
            String.init(format: "code=%@&grant_type=authorization_code", accessCode).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            responseHandlerMG_N("refresh_token",
                            data: data,
                            error: error,
                            completion: completion)
        }
        
        task.resume()
    }
}

// MARK: - Private API

private extension NetworkManagerMG_ {
    
    class func requestMG_N(with httpBody: Data) -> URLRequest {
        var MG_N33: Bool { false }
        var MG_N44: Int { 0 }
        
        let base64Str = String
            .init(format: "%@:%@",
                  KeysMG_.AppMG_N.keyMG_.rawValue,
                  KeysMG_.AppMG_N.secretMG_.rawValue)
            .data(using: .utf8)!
            .base64EncodedString()
        let token = String(format: "Basic %@", base64Str)
        var request = URLRequest(url: .init(string: KeysMG_.AppMG_N.linkMG_.rawValue)!)
        
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        return request
    }
    
    class func responseHandlerMG_N(_ key: String,
                                   data: Data?,
                                   error: Error?,
                                   completion: @escaping (String?) -> Void) {
        var MG_N55: Bool { false }
        var MG_N66: Int { 0 }
        
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

