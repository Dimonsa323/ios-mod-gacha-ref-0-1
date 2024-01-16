//
//  MG_ViewModel.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 14.01.2024.
//

import SwiftUI
import Resolver

@MainActor class MG_LoadingVM: ObservableObject {
    @Injected private var dropbox: Dropbox_ltlpm
    
  private func getData() {
        dropbox.getData(forPath: "/Mods.json") { [weak self] data in
            if let data = data {
                let str = String(decoding: data, as: UTF8.self)
                print(str)
            } else {
                print("Failed to retrieve data.")
            }
        }
    }
    
    func setupToken(completion: @escaping (Bool) -> Void) {
        dropbox.initDropBox { [weak self] success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                  print("OKKKKEEEYYYY nice job ")
                } else {
                    print("TOKEN LOADING FAILED")
                }
                completion(success)
            }
        }
    }
}
