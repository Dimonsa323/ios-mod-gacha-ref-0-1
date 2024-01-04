//
//  HomeView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 29.12.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image(.mods)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack() {
                        CustomSearchBar(searchText: $searchText)
                            .padding(.top, 20)
                        //    .padding(.horizontal, 20)
                        
                        HStack {
                            Text("M o d s")
                                .font(.custom("Comfortaa-Bold", size: 20))
                                .padding(.leading, 20)
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Text("See All")
                                    .foregroundStyle(.black)
                                    .font(.custom("Comfortaa-Medium", size: 16))
                                    .padding(.top, 20)
                                    .padding(.trailing, 20)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct CustomSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.search.opacity(0.6))
            
            TextField("Search", text: $searchText)
                .font(.custom("Comfortaa-Medium", size: 16))
                .foregroundColor(.search.opacity(0.6))
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding(.leading, 6)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding(.vertical, 7)
        .padding(.leading, 8)
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}


#Preview {
    HomeView()
}
