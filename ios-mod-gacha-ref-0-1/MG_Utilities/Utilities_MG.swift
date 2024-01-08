//
//  UtilitiesMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.01.2024.
//

import SwiftUI

final class MG_Utilities {
    
    static let shared = MG_Utilities()
    private init() {}
    
    func MG_widthAspectRatioDevice(width: CGFloat) -> CGFloat {
            if isIPad {
                return UIApplication.viewBoundsMG_.width * (width / 1024)
            } else {
                return UIApplication.viewBoundsMG_.width * (width / 390)
            }
        }
    
        func MG_heightAspectRatioDevice(height: CGFloat) -> CGFloat {
            if isIPad {
                return UIApplication.viewBoundsMG_.height * (height / 1366)
            } else {
                return UIApplication.viewBoundsMG_.height * (height / 844)
            }
        }
    
}


