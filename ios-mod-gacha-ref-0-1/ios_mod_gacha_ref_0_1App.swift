//
//  ios_mod_gacha_ref_0_1App.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.12.2023.
//

import SwiftUI

@main
struct ios_mod_gacha_ref_0_1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
