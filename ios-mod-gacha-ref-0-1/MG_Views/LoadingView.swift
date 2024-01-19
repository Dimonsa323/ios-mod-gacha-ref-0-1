//
//  LoadingView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 28.12.2023.
//

import SwiftUI
import Resolver

struct LoadingView: View {
    @Injected private var dropbox: MG_Dropbox
    
    @StateObject private var viewModel: MG_LoadingVM
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
            ZStackWithBackground {
                VStack(spacing: 28) {
                    Text("Loading...")
                        .foregroundStyle(.secondary1)
                        .MG_iosDeviceTypeFont(font: .init(name: .concert, style: .regular, iPhoneSize: 32, iPadSize: 64))
                    
                    ProgressView(value: progress) .progressViewStyle(BarProgressStyle(height: 28.0))
                        .tint(.secondary1)
                        .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 20, iPadPadding: 40)
                    
                        .task {
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                
                                withAnimation {
                                    
                                    if self.progress != 1.0 {
                                        // self.progress = 0.0
                                        self.progress += 0.1
                                    }
                                }
                            }
                        }
                }
            }
            .onAppear {
                
            }
        }
}

struct BarProgressStyle: ProgressViewStyle {
    var color: Color = .secondary1
    var height: Double = 28.0
    var labelFontStyle: Font = .body
    var verticalPadding: CGFloat = 5.0
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                configuration.label
                    .font(labelFontStyle)
                
                RoundedRectangle(cornerRadius: isIPad ? 40 : 20)
                    .fill(Color(uiColor: .white))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(color)
                            .frame(width: (geometry.size.width - 10) * progress, height: 18.0)
                            .padding(.all, verticalPadding)
                    }
            }
        }
        .frame(height: height)
    }
}

//#Preview {
//    LoadingView()
//}
