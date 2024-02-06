////
////  DropBoxManagerMG_.swift
////  ios-mod-gacha-ref-0-1
////
////  Created by Дима Губеня on 27.12.2023.
////

//import Foundation
//import SwiftyDropbox
//import DataCache
//
struct DropBoxKeys_ltlpm {
    static let appkey = "xezpvlrhwl66auw"
    static let appSecret = "jepz1de5cja0p2o"
    static let authCode = "czHFetFkAxAAAAAAAAAEe9V-c1UbHehRdha32aY_hTw"
    
    static let apiLink = "https://api.dropboxapi.com/oauth2/token"
    
    static let refreshToken = "Xh3GkFRCv5kAAAAAAAAAATWGSiIzuCaa14Bac_C1d1pVpR8nx_QCySv6Scwquqfu"
    
    
    // ⚠️⚠️⚠️ Setup DropBox ⚠️⚠️⚠️
    // open link first and copy code from website to static let authCode
    // https://www.dropbox.com/oauth2/authorize?client_id=5alcolhbotctae1&token_access_type=offline&response_type=code
}


final class Dropbox_ltlpm : NSObject {

    static let shared = Dropbox_ltlpm()

    public var client : DropboxClient?

    func initDropBox(complcetion: @escaping (Bool) -> Void) {
        
        DropboxClientsManager.setupWithAppKey(DropBoxKeys_ltlpm.appkey)
        
            getAccessToken(refreshToken: DropBoxKeys_ltlpm.refreshToken) { [weak self] accessToken in
                if let accessToken {
                    if let _ = self?.client {
                        print("client is already authorized 🫡 ")
                    } else {
                        self?.client = DropboxClient(accessToken: accessToken)
                    }
                    print("good job token update 🫡 \(accessToken),\(String(describing: self?.client))")
                } else {
                    print("error while getting access token ⚠️")
                }
                
                complcetion(true)
            }
        
//             getReshreshToken(authCode: DropBoxKeys_ltlpm.authCode) { refreshToken in
//                 if let refreshToken {
//                     print("refresh token ✅", refreshToken)
//                      self.getAccessToken(refreshToken: refreshToken) { access_token in
//                          if let access_token {
//                              self.client = DropboxClient(accessToken: access_token)
//                              print("good job first open token 🫡 \(access_token),\(String(describing: self.client))")
//                              completion(true)
//                          } else {
//                              completion(false)
//                          }
//                      }
//                 } else {
//                     print("error while getting refresh token ⚠️")
//                     completion(false)
//                 }
//             }
    }


     func getReshreshToken(authCode: String, completion: @escaping (String?) -> ()) {
    
        let username = DropBoxKeys_ltlpm.appkey
        let password = DropBoxKeys_ltlpm.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
    
        let parameters : Data = "code=\(authCode)&grant_type=authorization_code".data(using: .utf8)!
        let url = URL(string: DropBoxKeys_ltlpm.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
    
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                if let refreshToken = responseJSON["refresh_token"] as? String {
                    completion(refreshToken)
                } else {
                    // completion(DropBoxKeys_ltlpm.refreshToken)
                }
            } else {
                print("error")
            }
        }
    
        task.resume()
    }


    private func getAccessToken(refreshToken : String,completion: @escaping (String?) -> ()) {
        let username = DropBoxKeys_ltlpm.appkey
        let password = DropBoxKeys_ltlpm.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
    
        let parameters : Data = "refresh_token=\(refreshToken)&grant_type=refresh_token".data(using: .utf8)!
        let url = URL(string: DropBoxKeys_ltlpm.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
    
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(responseJSON["access_token"] as? String)
            }else {
                print("error")
            }
        }
    
        task.resume()
    }
}

// extension Dropbox_ltlpm {
//
//     func createFolder(folderPath: String) {
//         client?.files.createFolderV2(path: folderPath).response { response, error in
//             if let _ = response {
//                 print("Folder created in Dropbox: \(folderPath)")
//             } else if let error = error {
//                 print("Error creating folder in Dropbox: \(error)")
//             }
//         }
//     }
//
//     func downloadJSONFilesFromFolder(folderPath: String) {
//         guard let client = DropboxClientsManager.authorizedClient else {
//             print("Dropbox client not authorized.")
//             return
//         }
//
//         client.files.listFolder(path: folderPath).response { response, error in
//             if let result = response {
//                 let jsonFiles = result.entries.filter { entry -> Bool in
//                     if let file = entry as? Files.FileMetadata, let fileExtension = file.name.split(separator: ".").last {
//                         return fileExtension.lowercased() == "json"
//                     }
//                     return false
//                 }
//
//                 for file in jsonFiles {
//                     if let file = file as? Files.FileMetadata {
//                         client.files.download(path: file.pathLower!).response { response, error in
//                             if let (_, fileData) = response {
//                                 // File downloaded successfully
//                                 let fileName = (file.pathDisplay! as NSString).lastPathComponent
//                                 let json = try? JSONSerialization.jsonObject(with: fileData, options: [])
//                                 // Process the JSON data as needed
//                                 print("Downloaded JSON file: \(fileName)")
//                                 print("JSON data: \(json ?? "N/A")")
//                             } else if let error = error {
//                                 print("Error downloading file: \(file.name), \(error)")
//                             }
//                         }
//                     }
//                 }
//             } else if let error = error {
//                 print("Error listing folder: \(error)")
//             }
//         }
//     }
//
//     func uploadJSONFile(filePath: String, jsonData: Data) {
//         client?.files.upload(path: filePath, input: jsonData).response { response, error in
//             if let _ = response {
//                 print("JSON file uploaded to Dropbox: \(filePath)")
//             } else if let error = error {
//                 print("Error uploading JSON file: \(error)")
//             }
//         }
//     }
// }

extension Dropbox_ltlpm {
    
    func getAuthorizedClient(_ completion: @escaping (DropboxClient?) -> Void) {
        if let client {
            completion(client)
        } else {
            getAccessToken(refreshToken: DropBoxKeys_ltlpm.refreshToken) { [weak self] accessToken in
                if let accessToken {
                    if let client = self?.client {
                        completion(client)
                    } else {
                        let client = DropboxClient(accessToken: accessToken)
                        completion(client)
                        self?.client = client
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }

    func uploadJSONFile(filePath: String, from urlFrom: URL, completion: @escaping (String?) -> Void) {
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return completion("Dropbox client not authorized.")
            }

            client.files.upload(path: filePath, mode: .overwrite, input: urlFrom).response { response, error in
                if let _ = response {
                    print("JSON file uploaded to Dropbox: \(filePath)")
                    return completion(nil)
                } else if let error = error {
                    print("Error uploading JSON file: \(error)")
                    return completion(error.description)
                }
            }
        }
    }

    func downloadJSONFile(filePath: String, completion: @escaping (Data?) -> Void) {
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return completion(nil)
            }
            
            client.files.download(path: filePath).response { response, error in
                if let response {
                    let data = response.1
                    print("JSON file downloaded from Dropbox: \(filePath)")
                    return completion(data)
                } else if let error {
                    print("Error downloading JSON file for path: \(filePath), \nerror: \(error)")
                    return completion(nil)
                }
            }
        }
    }

    func removeFolder(_ filePath: String) {
        getAuthorizedClient { client in
            client?.files.deleteV2(path: filePath)
        }
    }
    
    func getFileDownloadLink(filePath: String, completion: @escaping (URL?) -> Void) {
        let filePath = filePath.starts(with: "/") ? filePath : "/" + filePath
        
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return completion(nil)
            }
            
            client.files.getTemporaryLink(path: filePath).response { response, error in
                if let result = response {
                    completion(URL(string: result.link))
                    print("Download Link: \(result.link)")
                } else if let error = error {
                    completion(nil)
                    print("Error getting temporary link: \(error)")
                }
            }
        }
    }
}

extension Dropbox_ltlpm {
    
    // METHOD WITH CACHE CHEKING
    
    func getData(forPath path: String, completion: @escaping (Data?) -> Void) {
        let path = path.starts(with: "/") ? path : "/" + path
        
        if let data = DataCache.instance.readData(forKey: path) {
            completion(data)
        } else {
            downloadJSONFile(filePath: path) { data in
                if let data {
                    DataCache.instance.write(data: data, forKey: path)
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }
    }
}

