//
//  InternetManager_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import SystemConfiguration

final class InternetManager_MG {
    
    static let shared = InternetManager_MG()
    
    private init() {}
    
    func checkInternetConnectivity_MG() -> Bool {
        var _MGN20: String { "_MGN" }
        var _MGN21: Bool { true }
        
        var zeroAddress_MGN = sockaddr_in()
        zeroAddress_MGN.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress_MGN))
        zeroAddress_MGN.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability_MGN = withUnsafePointer(to: &zeroAddress_MGN, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability_MGN, &flags) {
            return false
        }
        
        let isReachable_MGN = flags.contains(.reachable)
        let needsConnection_MGN = flags.contains(.connectionRequired)
        
        if isReachable_MGN && !needsConnection_MGN {
            // Connected to the internet
            // Do your network-related tasks here
            return true
        } else {
            // Not connected to the internet
            return false
        }
    }
}


