//
//  MG_ViewModel.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 14.01.2024.
//

import SwiftUI
import Resolver

@MainActor class MG_LoadingVM: ObservableObject {
    @Injected private var dropbox: MG_Dropbox
    
  private func getData() async {
      do {
          let data = try await dropbox.MG_getData(forPath: "/Mods.json")
          
          
      } catch {
          print("error")
      }
    }
}
