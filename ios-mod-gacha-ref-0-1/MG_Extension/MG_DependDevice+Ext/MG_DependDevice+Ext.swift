//
//  DependDevice+ExtMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.01.2024.
//

import Foundation
import SwiftUI

var idiom: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
var isIPad: Bool { idiom == .pad }

extension View {
    func iosDeviceTypePadding(edge: Edge.Set, iOSPadding: CGFloat, iPadPadding: CGFloat, iPadIsAspect: Bool
    ) -> some View {
        return modifier(MG_DevicePaddingModifier(
             edge: edge,
             iOSPadding: iOSPadding,
             iPadPadding: iPadPadding,
             iPadIsAspect: iPadIsAspect
         ))
    }
}

struct MG_DevicePaddingModifier: ViewModifier {
    let edge: Edge.Set
    let iOSPadding: CGFloat
    let iPadPadding: CGFloat
    let iPadIsAspect: Bool
    
    var MG_iPadPadding: CGFloat {
        iPadIsAspect ? MG_Utilities.shared.MG_widthAspectRatioDevice(width: iPadPadding) : iPadPadding
        
    }
    
    var paddingMG_: CGFloat {
        idiom == .pad ? MG_iPadPadding : iOSPadding
    }
    
    func body(content: Content) -> some View {
        content
            .padding(edge, paddingMG_)
    }
    
}
