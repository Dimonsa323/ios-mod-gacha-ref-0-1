//
//  CharactersView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 29.12.2023.
//

import SwiftUI

struct CharactersView: View {
    var body: some View {
        ZStack {
            Image(.mods)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Label")
                    .padding(8)
                    .addBackground(color: .red)
            }
        }
    }
}

#Preview {
    CharactersView()
}
