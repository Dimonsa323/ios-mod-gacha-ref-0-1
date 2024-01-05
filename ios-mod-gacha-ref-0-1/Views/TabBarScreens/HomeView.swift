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
                            Text("Mods")
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
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<5) { index in
                                    VStack(alignment: .leading) {
                                        Image(.moko)
                                            .cornerRadius(16)
                                            .padding(.all, 12)
                                        Text("Mod Name \(index + 1)")
                                            .font(.custom("Comfortaa-Bold", size: 20))
                                            .padding(.bottom, 12)
                                            .padding(.leading, 12)
                                    }
                                    .background(.modsCellBackground)
                                    .cornerRadius(16)
                                    .padding(.top, 12)
                                    //                                        .padding(.leading, 20)
                                    .padding(.trailing, 4)
                                    .padding(.leading, index == 0 ? 20 : 0)
                                   // .padding(.trailing, index == 0 ? 5 : 0)
//                                    .overlay(
//                                        index == 1 ? Color.clear.frame(width: 20) : nil,
//                                        alignment: .leading
//                                    )
                                }
                            }
                        }.frame(height: 220)
                        
                        VStack {
                            HStack {
                                Text("Outfit ideas")
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
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0..<10) { index in
                                        VStack(alignment: .leading) {
                                            Image(.mocoImage2)
                                                .cornerRadius(20)
                                                .padding(.all, 8)
                                        }
                                        .border(Color.white, width: 1)
                                        .background(.whiteLight)
                                        .cornerRadius(20)
                                        .padding(.top, 12)
                                        .padding(.trailing, 8)
                                        .padding(.leading, 20)
//                                        .offset(x: index == 0 ? 20 : 0)
                                    }
                                }
                            }.frame(height: 242)
                            
                            HStack {
                                Text("Collections")
                                    .font(.custom("Comfortaa-Bold", size: 20))
                                    .padding(.leading, 20)
                                    .padding(.top, 24)
                                
                                Spacer()
                                
                                Button {
                                    //
                                } label: {
                                    Text("See All")
                                        .foregroundStyle(.black)
                                        .font(.custom("Comfortaa-Medium", size: 16))
                                        .padding(.top, 24)
                                        .padding(.trailing, 20)
                                }
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
