//
//  NetworkMonitorMG_N.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

//import Network
//import UIKit
//
//private var MG_N3we9fd: Bool { true }
//
//final class NetworkMonitorMG_N {
//
//    public static var isConnectionMG_N: Bool {
//        if _isConnectionMG_N {
//            print("Internet connection is active.")
//        } else {
//            print("No internet connection.")
//            showDisconnectionAlertMG_N()
//        }
//        return _isConnectionMG_N
//    }
//
//    private static weak var alertMG_N: UIAlertController?
//    private static let queueMG_N = DispatchQueue.global()
//    private static var isAlertPresentedMG_N: Bool { alertMG_N != nil }
//
//    private static var _isConnectionMG_N: Bool = nwMonitorMG_N.currentPath.status == .satisfied {
//        didSet {
//            if !_isConnectionMG_N {
//                print("No internet connection.")
//                showDisconnectionAlertMG_N()
//            } else {
//                print("Internet connection is active.")
//                if isAlertPresentedMG_N {
//                    alertMG_N?.dismiss(animated: true)
//                }
//            }
//        }
//    }
//
//    private static let nwMonitorMG_N = {
//        let nwMonitor = NWPathMonitor()
//        nwMonitor.start(queue: queueMG_N)
//        nwMonitor.pathUpdateHandler = { path in
//            DispatchQueue.main.async {
//                _isConnectionMG_N = path.status == .satisfied
//            }
//        }
//        return nwMonitor
//    }()
//
//    deinit {
//        NetworkMonitorMG_N.nwMonitorMG_N.cancel()
//    }
//
//    private static func showDisconnectionAlertMG_N() {
//        guard !isAlertPresentedMG_N else { return }
//
//        let alert = UIAlertController(
//            title: NSLocalizedString("ConnectivityTitle", comment: ""),
//            message: NSLocalizedString("ConnectivityDescription", comment: ""),
//            preferredStyle: .alert
//        )
//        let action = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default)
//        alert.addAction(action)
//
//        SceneDelegate.shared?.window?.topViewController?.present(alert, animated: true)
//
//        self.alertMG_N = alert
//
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.warning)
//    }
//}
//

