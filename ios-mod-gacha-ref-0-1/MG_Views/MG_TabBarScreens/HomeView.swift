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
//        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image(.mods)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        CustomSearchBar(searchText: $searchText)
                            .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 20, iPadPadding: 40)
                        
                        HStack(spacing: 0) {
                            Text("Mods")
                                .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .bold, iPhoneSize: 20, iPadSize: 40))
                                .MG_iosDeviceTypePadding(edge: .leading, iOSPadding: 20, iPadPadding: 40)
                                .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 20, iPadPadding: 40)
                            
                            Spacer()
                            
                            Button {
                                //
                            } label: {
                                Text("See All")
                                    .foregroundStyle(Color.black)
                                    .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .medium, iPhoneSize: 16, iPadSize: 32))
                                    .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 20, iPadPadding: 40)
                                    .MG_iosDeviceTypePadding(edge: .trailing, iOSPadding: 20, iPadPadding: 40)
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {
                                ForEach(0..<5) { index in
                                    VStack(alignment: .leading) {
                                        Image(.moko)
                                            .resizable()
                                            .MG_cornerRadius(isIPad ? 32 : 16, corners: .allCorners)
                                            .MG_iosDeviceTypePadding(edge: .all, iOSPadding: 12, iPadPadding: 24)
                                        Text("Mod Name \(index + 1)")
                                            .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .bold, iPhoneSize: 20, iPadSize: 40))
                                            .MG_iosDeviceTypePadding(edge: .bottom, iOSPadding: 12, iPadPadding: 24)
                                            .MG_iosDeviceTypePadding(edge: .leading, iOSPadding: 12, iPadPadding: 24)
                                    }
                                    .background(.modsCellBackground)
                                    .MG_cornerRadius(isIPad ? 32 : 16, corners: .allCorners)
                                    .MG_iosDeviceTypePadding(edge: .trailing, iOSPadding: 4, iPadPadding: 8)
                                }
                            }
                            .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 12, iPadPadding: 24)
                            .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 20, iPadPadding: 40)
                            
                        }
                        .MG_iosDeviceTypeFrame(iOSHeight: 220, iPadHeight: 440)
                        
                        VStack {
                            HStack(spacing: 0) {
                                Text("Outfit ideas")
                                    .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .bold, iPhoneSize: 20, iPadSize: 40))
                                    .MG_iosDeviceTypePadding(edge: .leading, iOSPadding: 20, iPadPadding: 40)
                                    .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 20, iPadPadding: 40)
                                
                                Spacer()
                                
                                Button {
                                    //
                                } label: {
                                    Text("See All")
                                        .foregroundStyle(Color.black)
                                        .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .medium, iPhoneSize: 16, iPadSize: 32))
                                        .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 20, iPadPadding: 40)
                                        .MG_iosDeviceTypePadding(edge: .trailing, iOSPadding: 20, iPadPadding: 40)
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack() {
                                    ForEach(0..<10) { index in
                                        
                                        Image(.mocoImage2)
                                            .resizable()
                                            .MG_cornerRadius(20, corners: .allCorners)
                                            .MG_iosDeviceTypePadding(edge: .all, iOSPadding: 8, iPadPadding: 16)
                                            .background(.whiteLight)
                                            .MG_cornerRadius(20, corners: .allCorners)
                                    }
                                }
                                .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 12, iPadPadding: 24)
                                .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 20, iPadPadding: 40)
                                
                            }
                            .MG_iosDeviceTypeFrame(iOSHeight: 242, iPadHeight: 484)
                            
                            HStack(spacing: 0) {
                                Text("Collections")
                                    .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .bold, iPhoneSize: 20, iPadSize: 40))
                                    .MG_iosDeviceTypePadding(edge: .leading, iOSPadding: 20, iPadPadding: 40)
                                    .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 24, iPadPadding: 48)
                                
                                Spacer()
                                
                                Button {
                                    //
                                } label: {
                                    Text("See All")
                                        .foregroundStyle(Color.black)
                                        .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .medium, iPhoneSize: 16, iPadSize: 32))
                                        .MG_iosDeviceTypePadding(edge: .top, iOSPadding: 24, iPadPadding: 48)
                                        .MG_iosDeviceTypePadding(edge: .trailing, iOSPadding: 20, iPadPadding: 40)
                                }
                            }
                        }
                        
                        Spacer()
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
                .foregroundColor(Color.search.opacity(0.6))
            
            TextField("Search", text: $searchText)
                .MG_iosDeviceTypeFont(font: .init(name: .comfortaa, style: .medium, iPhoneSize: 16, iPadSize: 32))
                .foregroundColor(Color.search.opacity(0.6))
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                        .MG_iosDeviceTypePadding(edge: .leading, iOSPadding: 6, iPadPadding: 12)
                        .MG_iosDeviceTypePadding(edge: .trailing, iOSPadding: 8, iPadPadding: 16)
                }
            }
        }.frame(height: isIPad ? 52 : 26)
            
            .MG_iosDeviceTypePadding(edge: .vertical, iOSPadding: 7, iPadPadding: 14)
            .MG_iosDeviceTypePadding(edge: .leading, iOSPadding: 8, iPadPadding: 16)
            .background(Color.white.opacity(0.6))
            .MG_cornerRadius(isIPad ? 20 : 10, corners: .allCorners)
            .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 20, iPadPadding: 40)
    }
}


#Preview {
    HomeView()
}
