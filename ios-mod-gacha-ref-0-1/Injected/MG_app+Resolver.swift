//
//  MG_app+Resolver.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 15.01.2024.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register { Dropbox_ltlpm() }.scope(.application)
//        register { TTLS_NetworkMonitoringManager() }.scope(.application)
//        register { TTLS_CoreDataStore() }.scope(.application)
//        register { TTLS_MainNavigationStore() }.scope(.application)
//        register { TTLS_SaverManager() }.scope(.application)
//        register { TTLS_HomeDataAPI() }.scope(.application)
    }
}

