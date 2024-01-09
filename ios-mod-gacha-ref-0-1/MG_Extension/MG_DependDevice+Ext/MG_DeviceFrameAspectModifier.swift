//
//  MG_DeviceFrameAspectModifier.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 08.01.2024.
//

import SwiftUI

extension MG_View {
    func MG_iosDeviceTypeFrameAspec(
        iOSWidth: CGFloat? = nil,
        iOSHeight: CGFloat? = nil,
        isiOsAspec: Bool = false,
        iPadWidth: CGFloat? = nil,
        iPadHeight: CGFloat? = nil,
        isiPadAspec: Bool = true
    ) -> some View {
        modifier(MG_DeviceFrameAspectModifier(
            iOSWidth: iOSWidth,
            iOSHeight: iOSHeight,
            iPadWidth: iPadWidth,
            iPadHeight: iPadHeight,
            isiPadAspec: isiPadAspec,
            isiOsAspec: isiOsAspec
        ))
    }
}

struct MG_DeviceFrameAspectModifier: ViewModifier {
    var iOSWidth: CGFloat?
    var iOSHeight: CGFloat?
    var iPadWidth: CGFloat?
    var iPadHeight: CGFloat?
    let isiPadAspec: Bool
    let isiOsAspec: Bool

    let iPadSize: CGSize = .init(width: 1024, height: 1366)
    let iPhoneSize: CGSize = .init(width: 390, height: 844)

    var MG_width: CGFloat? {
        if idiom == .pad {
            if let iPadWidth  {
                if isiPadAspec {
                    return MG_Utilities.shared.MG_widthWithOpt(aspectRatio: iPadWidth / iPadSize.width)
                } else {
                    return iPadWidth
                }

            } else {
                return nil
            }

        } else {
            if let iOSWidth {
                if isiOsAspec {
                    return MG_Utilities.shared.MG_widthWithOpt(aspectRatio: iOSWidth / iPhoneSize.width)
                } else {
                    return iOSWidth
                }
            } else {
                return nil
            }
        }
    }

    var MG_height: CGFloat? {
        if idiom == .pad {
            if let iPadHeight {
                if isiPadAspec {
                    return MG_Utilities.shared.MG_heightWithOpt(aspectRatio: iPadHeight / iPadSize.height)
                } else {
                    return iPadHeight
                }
            } else {
                return nil
            }

        } else {
            if let iOSHeight {
                if isiOsAspec {
                    return MG_Utilities.shared.MG_heightWithOpt(aspectRatio: iOSHeight / iPhoneSize.height)
                } else {
                    return iOSHeight
                }
            } else {
                return nil
            }
        }
    }

    func body(content: Content) -> some View {
        content
            .frame(
                width: MG_width,
                height: MG_height
            )
    }
}
