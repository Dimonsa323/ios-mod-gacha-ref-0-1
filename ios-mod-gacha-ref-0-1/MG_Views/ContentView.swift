//
//  ContentView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 26.12.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    var body: some View {
        Text("Text")
    }
}
    
    #Preview {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
