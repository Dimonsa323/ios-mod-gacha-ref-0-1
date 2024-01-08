//
//  LoadingView.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 28.12.2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
            ZStack {
                Image(.mods)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 28) {
                    Text("Loading...")
                        .foregroundStyle(.secondary1)
                        .font(.custom("ConcertOne-Regular", size: 32))
                    
                    ProgressView(value: progress) .progressViewStyle(BarProgressStyle(height: 28.0))
                        .tint(.secondary1)
                        .padding(.horizontal, 20)
                    
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
                
                RoundedRectangle(cornerRadius: 20.0)
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

#Preview {
    LoadingView()
}
