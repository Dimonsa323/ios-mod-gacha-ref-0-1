//
//  ContentView.swift
//  mods-for-melon-playgorund
//
//  Created by Александр Ковалев on 11.12.2023.
//

import SwiftUI
import CoreData

struct MG_ContentView: View {

    @State private var splashScreenIsShow: Bool = false
    @State private var sheetType: MG_CustomSheetModel?

    var body: some View {
        VStack(spacing: 0) {
            if splashScreenIsShow {
                MG_FlowView()
            } else {
                MG_SplashScreen(splashScreenIsShow: $splashScreenIsShow)
            }
        }
        .showCustomSheet(sheetType: $sheetType)
        .MG_onCreateSheet { type in
            withAnimation(.default.speed(1)) {
                sheetType = type
            }
        }
        .task {
            await Task.MG_sleep(seconds: 1)
            MG_ThirdPartyServicesManager.shared.MG_makeATT()
        }
    }

}

#Preview {
    MG_ContentView()
}
