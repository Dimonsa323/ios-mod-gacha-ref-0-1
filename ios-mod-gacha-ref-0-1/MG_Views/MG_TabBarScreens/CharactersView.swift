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
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        //
                    } label: {
                        Image(.navBarBack)
                        
                        Spacer()
                        
                        Text("Mod")
                            
                            .foregroundStyle(.black)
                            .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .regular, iPhoneSize: 28, iPadSize: 56))
                        
                        Spacer()
                        
                        Button {
                            //
                        } label: {
                            Image(.starFavorite)
                                .border(.red)
                        }

                    }
                   
                }
                
            }
            Spacer()
        }
    }
}

#Preview {
    CharactersView()
}
