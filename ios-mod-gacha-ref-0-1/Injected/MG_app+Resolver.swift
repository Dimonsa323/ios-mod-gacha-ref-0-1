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
        
        register { MG_Dropbox() }.scope(.application)
//        register { MG_NetworkMonitoringManager() }.scope(.application)
//        register { MG_CoreDataStore() }.scope(.application)
//        register { MG_MainNavigationStore() }.scope(.application)
//        register { MG_SaverManager() }.scope(.application)
//        register { MG_HomeDataAPI() }.scope(.application)
    }
}

