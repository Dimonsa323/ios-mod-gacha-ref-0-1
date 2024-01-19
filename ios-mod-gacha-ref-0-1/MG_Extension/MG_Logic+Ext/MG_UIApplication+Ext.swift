//
//  MG_UIApplication+Ext.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 17.01.2024.
//

import UIKit

typealias MG_UIApplication = UIApplication

extension MG_UIApplication {
    func MG_addTapGestureRecognizer() {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        guard let window = UIApplication.shared.MG_currentKeyWindow else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension MG_UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        return false // set to `false` if you don't want to detect tap during other gestures
    }
}

extension MG_UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension MG_UIApplication {
    static var MG_viewBounds: CGSize {
        UIApplication.shared.MG_currentKeyWindow?.screen.bounds.size ?? .zero
    }
}

extension MG_UIApplication {
  var MG_currentKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
//      .filter { $0.activationState == .foregroundActive }
      .map { $0 as? UIWindowScene }
      .compactMap { $0 }
      .first?.windows
      .filter { $0.isKeyWindow }
      .first
  }

    var MG_currentScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive
        }) as? UIWindowScene
    }

    var MG_rootViewController: UIViewController? {
        MG_currentKeyWindow?.rootViewController
    }

    var MG_keyWindowPresentedController: UIViewController? {
        var viewController = MG_currentKeyWindow?.rootViewController
        if let presentedController = viewController as? UITabBarController {
            viewController = presentedController.selectedViewController
        }
        while let presentedController = viewController?.presentedViewController {
            if let presentedController = presentedController as? UITabBarController {
                viewController = presentedController.selectedViewController
            } else {
                viewController = presentedController
            }
        }
        return viewController
    }
}

