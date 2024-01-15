//
//  MG_ViewModel.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 14.01.2024.
//

import SwiftUI

extension ContentView {
  @MainActor class MG_ViewModel: ObservableObject {
        
    }
}

//struct MockView: View {
//    @State private var text: String = ""
//    
//    @StateObject var vm: VM = VM()
//    
//    let number: Int = 5
//    
//    var body: some View {
//        VStack {
//            Text(vm.name)
//            SecondView()
//                .environmentObject(vm)
//        }
//    }
//}
//
//struct SecondView: View {
//    @EnvironmentObject var vm: VM
//    
//    var body: some View {
//        Text(vm.name + String(vm.number))
//    }
//}
//
//
//class VM: ObservableObject {
//    @Published var text: String = ""
//    @Published var number: Int = 0
//    
//    var name: String = "Sasha"
//}
