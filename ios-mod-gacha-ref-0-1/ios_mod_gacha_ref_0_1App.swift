//
//  ios_mod_gacha_ref_0_1App.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.12.2023.
//

import SwiftUI
import Resolver

@main
struct ios_mod_gacha_ref_0_1App: App {
   // @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Injected private var dropbox: MG_Dropbox
 //   @Injected private var coreDataStore: MG_CoreDataStore
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear { MG_basicSetup() }
            //    .preferredColorScheme(.light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func MG_basicSetup() {
        
        UIApplication.shared.MG_addTapGestureRecognizer()
        dropbox.MG_init_Dropbox()

        UIButton.appearance().isMultipleTouchEnabled = false
        UIButton.appearance().isExclusiveTouch = true
        UIView.appearance().isMultipleTouchEnabled = false
        UIView.appearance().isExclusiveTouch = true
    }
}
