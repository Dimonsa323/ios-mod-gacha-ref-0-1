//
//  MG_CustomSearchBar+Ext.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 10.01.2024.
//

import SwiftUI

struct MG_CustomSearchBar_Ext: View {
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

//#Preview {
//    MG_CustomSearchBar_Ext()
//}
