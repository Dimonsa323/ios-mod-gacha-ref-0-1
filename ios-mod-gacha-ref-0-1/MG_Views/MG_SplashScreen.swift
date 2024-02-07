//
//  MG_SplashScreen.swift
//  mods-for-melon-playgorund
//
//  Created by Дима Губеня on 23.12.2023.
//

import SwiftUI
import Resolver
import HYSLogger

struct MG_SplashScreen: View {
    @Injected private var apiManager: MG_HomeDataAPI
    @Injected private var networkManager: MG_NetworkMonitoringManager

    @FetchRequest<MG_SkinsMO>(fetchRequest: .MG_skins())
    private var skins
    @State private var downloadedFile: Double = 0
    @Binding var splashScreenIsShow: Bool

    var body: some View {
        MG_ZStackWithBackground {
            VStack(spacing: isIPad ? 32 : 16 ) {
                HStack(spacing: 0) {
                    Text("Please wait")
                    Spacer()
                    Text("100%")
                        .monospacedDigit()
                        .opacity(0)
                        .animatingOverlay(for: Double(Int(downloadedFile) * 100 / MG_ContentType.apiMenus.count))
                }
                .MG_iosDeviceTypeFont(font: .init(name: .sfProDisplay, style: .bold, iPhoneSize: 18, iPadSize: 32))

                ProgressView(value: downloadedFile, total: Double(MG_ContentType.apiMenus.count))
                    .progressViewStyle(MG_BarProgressStyle(animation: .easeInOut(duration: 1)))
            }
            .MG_iosDeviceTypePadding(edge: [.horizontal, .top], iOSPadding: 12, iPadPadding: 24)
            .MG_iosDeviceTypePadding(edge: .bottom, iOSPadding: 8, iPadPadding: 16)
            .MG_addRoundedModifier(radius: isIPad ? 36 : 18, bgColor: .yellowMG)
            .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 51, iPadPadding: 51)
            .frame(maxWidth: 700)
        }
        .task {
            await firstDownloading()
        }
    }
}

private extension MG_SplashScreen {

    func firstDownloading() async {
        if networkManager.MG_isReachable()  {
            await MG_downloadingStream()
        } else {
            if skins.isEmpty {
                await MG_downloadingStream()
            } else {
                splashScreenIsShow = true
                Logger.debug("All downloaded success")
            }
        }
    }

    func MG_downloadingStream() async {
        let operations: [MG_ContentType] = MG_ContentType.apiMenus

        await stream(type: operations)

        await Task.MG_sleep(seconds: 1)
        Logger.debug("All downloaded success")
        splashScreenIsShow = true
    }

    func stream(type: [MG_ContentType]) async {
        await withThrowingTaskGroup(of: Void.self) { group in
            for t in type {
                switch t {
                case .mods:
                    group.addTask {
                        await MG_Utilities.shared.MG_retrowThrowsFunction {
                            try await apiManager.MG_getModels(type: .mods)
                            await updateProgress()
                        }
                    }
                case .skins:
                    group.addTask {
                        await MG_Utilities.shared.MG_retrowThrowsFunction {
                            try await apiManager.MG_getModels(type: .skins)
                            await updateProgress()
                        }
                    }
                case .tanks:
                    group.addTask {
                        await MG_Utilities.shared.MG_retrowThrowsFunction {
                            try await apiManager.MG_getModels(type: .tanks)
                            await updateProgress()
                        }
                    }
                case .buildings:
                    group.addTask {
                        await MG_Utilities.shared.MG_retrowThrowsFunction {
                            try await apiManager.MG_getModels(type: .buildings)
                            await updateProgress()
                        }
                    }
                case .editor:
                    group.addTask {
                        await MG_Utilities.shared.MG_retrowThrowsFunction {
                            try await apiManager.MG_getModels(type: .editor)
                            await updateProgress()
                        }
                    }
                case .category:
                    group.addTask {
                        await MG_Utilities.shared.MG_retrowThrowsFunction {
                            try await apiManager.MG_getModels(type: .category)
                            await updateProgress()
                        }
                    }
                default:
                    break
                }
            }
        }
    }

    func updateProgress() {
        withAnimation(.easeInOut(duration: 1)) {
            downloadedFile += 1
        }
    }
}

#Preview {
    MG_SplashScreen(splashScreenIsShow: .constant(false))
}
