//
//  ContentView.swift
//  mods-for-melon-playgorund
//
//  Created by Александр Ковалев on 11.12.2023.
//

import SwiftUI
import CoreData

struct TTLS_ContentView: View {

    @State private var splashScreenIsShow: Bool = false
    @State private var sheetType: TTLS_CustomSheetModel?

    var body: some View {
        VStack(spacing: 0) {
            if splashScreenIsShow {
                TTLS_FlowView()
            } else {
                TTLS_SplashScreen(splashScreenIsShow: $splashScreenIsShow)
            }
        }
        .showCustomSheet(sheetType: $sheetType)
        .TTLS_onCreateSheet { type in
            withAnimation(.default.speed(1)) {
                sheetType = type
            }
        }
        .task {
            await Task.TTLS_sleep(seconds: 1)
            TTLS_ThirdPartyServicesManager.shared.TTLS_makeATT()
        }
    }

}

#Preview {
    TTLS_ContentView()
}
