//
//  MG_ContentView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 10.01.2024.
//

import SwiftUI

struct ZStackWithBackground<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
        ZStack {
            Image(.mods)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            content()
        }
    }
}


//#Preview {
//    ZStackWithBackground()
//}
