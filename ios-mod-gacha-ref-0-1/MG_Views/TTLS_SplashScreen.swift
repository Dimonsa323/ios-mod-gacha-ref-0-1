//
//  TTLS_SplashScreen.swift
//  mods-for-melon-playgorund
//
//  Created by Александр Ковалев on 23.12.2023.
//

import SwiftUI
import Resolver
import HYSLogger

struct TTLS_SplashScreen: View {
    @Injected private var apiManager: TTLS_HomeDataAPI
    @Injected private var networkManager: TTLS_NetworkMonitoringManager

    @FetchRequest<TTLS_SkinsMO>(fetchRequest: .ttls_skins())
    private var skins
    @State private var downloadedFile: Double = 0
    @Binding var splashScreenIsShow: Bool

    var body: some View {
        TTLS_ZStackWithBackground {
            VStack(spacing: isIPad ? 32 : 16 ) {
                HStack(spacing: 0) {
                    Text("Please wait")
                    Spacer()
                    Text("100%")
                        .monospacedDigit()
                        .opacity(0)
                        .animatingOverlay(for: Double(Int(downloadedFile) * 100 / TTLS_ContentType.apiMenus.count))
                }
                .TTLS_iosDeviceTypeFont(font: .init(name: .sfProDisplay, style: .bold, iPhoneSize: 18, iPadSize: 32))

                ProgressView(value: downloadedFile, total: Double(TTLS_ContentType.apiMenus.count))
                    .progressViewStyle(TTLS_BarProgressStyle(animation: .easeInOut(duration: 1)))
            }
            .TTLS_iosDeviceTypePadding(edge: [.horizontal, .top], iOSPadding: 12, iPadPadding: 24)
            .TTLS_iosDeviceTypePadding(edge: .bottom, iOSPadding: 8, iPadPadding: 16)
            .TTLS_addRoundedModifier(radius: isIPad ? 36 : 18, bgColor: .yellowTTLS)
            .TTLS_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 51, iPadPadding: 51)
            .frame(maxWidth: 700)
        }
        .task {
            await firstDownloading()
        }
    }
}

private extension TTLS_SplashScreen {

    func firstDownloading() async {
        if networkManager.TTLS_isReachable()  {
            await TTLS_downloadingStream()
        } else {
            if skins.isEmpty {
                await TTLS_downloadingStream()
            } else {
                splashScreenIsShow = true
                Logger.debug("All downloaded success")
            }
        }
    }

    func TTLS_downloadingStream() async {
        let operations: [TTLS_ContentType] = TTLS_ContentType.apiMenus

        await stream(type: operations)

        await Task.TTLS_sleep(seconds: 1)
        Logger.debug("All downloaded success")
        splashScreenIsShow = true
    }

    func stream(type: [TTLS_ContentType]) async {
        await withThrowingTaskGroup(of: Void.self) { group in
            for t in type {
                switch t {
                case .mods:
                    group.addTask {
                        await TTLS_Utilities.shared.TTLS_retrowThrowsFunction {
                            try await apiManager.TTLS_getModels(type: .mods)
                            await updateProgress()
                        }
                    }
                case .skins:
                    group.addTask {
                        await TTLS_Utilities.shared.TTLS_retrowThrowsFunction {
                            try await apiManager.TTLS_getModels(type: .skins)
                            await updateProgress()
                        }
                    }
                case .tanks:
                    group.addTask {
                        await TTLS_Utilities.shared.TTLS_retrowThrowsFunction {
                            try await apiManager.TTLS_getModels(type: .tanks)
                            await updateProgress()
                        }
                    }
                case .buildings:
                    group.addTask {
                        await TTLS_Utilities.shared.TTLS_retrowThrowsFunction {
                            try await apiManager.TTLS_getModels(type: .buildings)
                            await updateProgress()
                        }
                    }
                case .editor:
                    group.addTask {
                        await TTLS_Utilities.shared.TTLS_retrowThrowsFunction {
                            try await apiManager.TTLS_getModels(type: .editor)
                            await updateProgress()
                        }
                    }
                case .category:
                    group.addTask {
                        await TTLS_Utilities.shared.TTLS_retrowThrowsFunction {
                            try await apiManager.TTLS_getModels(type: .category)
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
    TTLS_SplashScreen(splashScreenIsShow: .constant(false))
}
