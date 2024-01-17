//
//  InternetManagerMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import SystemConfiguration

final class InternetManagerMG_ {
    
    static let shared = InternetManagerMG_()
    
    private init() {}
    
    func checkInternetConnectivityMG_() -> Bool {
        var MG_N20: String { "MG_N" }
        var MG_N21: Bool { true }
        
        var zeroAddressMG_N = sockaddr_in()
        zeroAddressMG_N.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddressMG_N))
        zeroAddressMG_N.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachabilityMG_N = withUnsafePointer(to: &zeroAddressMG_N, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachabilityMG_N, &flags) {
            return false
        }
        
        let isReachableMG_N = flags.contains(.reachable)
        let needsConnectionMG_N = flags.contains(.connectionRequired)
        
        if isReachableMG_N && !needsConnectionMG_N {
            // Connected to the internet
            // Do your network-related tasks here
            return true
        } else {
            // Not connected to the internet
            return false
        }
    }
}


