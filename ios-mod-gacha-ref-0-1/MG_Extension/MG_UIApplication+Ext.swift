//
//  UIApplication+ExtMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 06.01.2024.
//

import UIKit

typealias UIApplicationMG_ = UIApplication

extension UIApplicationMG_ {
    static var viewBoundsMG_: CGSize {
        UIApplication.shared.currentKeyWindowMG_?.screen.bounds.size ?? .zero
    }}

extension UIApplicationMG_ {
    var currentKeyWindowMG_: UIWindow? {
        UIApplication.shared.connectedScenes
        //      .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }
}
