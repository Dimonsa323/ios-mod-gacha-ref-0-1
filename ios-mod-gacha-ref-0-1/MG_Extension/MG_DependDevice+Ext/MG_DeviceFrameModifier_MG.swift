//
//  MG_DeviceFrameModifier_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 08.01.2024.
//

import SwiftUI

extension MG_View {
    func MG_iosDeviceTypeFrame(
        iOSWidth: CGFloat? = nil,
        iOSHeight: CGFloat? = nil,
        iPadWidth: CGFloat? = nil,
        iPadHeight: CGFloat? = nil
    ) -> some View {
        
        return modifier(MG_DeviceFrameModifier(
            iOSWidth: iOSWidth,
            iOSHeight: iOSHeight,
            iPadWidth: iPadWidth,
            iPadHeight: iPadHeight
        ))
    }
}

struct MG_DeviceFrameModifier: ViewModifier {
    var iOSWidth: CGFloat?
    var iOSHeight: CGFloat?
    var iPadWidth: CGFloat?
    var iPadHeight: CGFloat?

    var size_MG: (w: CGFloat?, h: CGFloat?) {
        idiom == .pad ? (iPadWidth, iPadHeight) : (iOSWidth, iOSHeight)
    }

    func body(content: Content) -> some View {
        content
            .frame(
                width: size_MG.w,
                height: size_MG.h
            )
    }
}

