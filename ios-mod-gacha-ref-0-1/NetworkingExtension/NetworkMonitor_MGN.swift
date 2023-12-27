//
//  NetworkMonitor_MGN.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

//import Network
//import UIKit
//
//private var _MGN3we9fd: Bool { true }
//
//final class NetworkMonitor_MGN {
//
//    public static var isConnection_MGN: Bool {
//        if _isConnection_MGN {
//            print("Internet connection is active.")
//        } else {
//            print("No internet connection.")
//            showDisconnectionAlert_MGN()
//        }
//        return _isConnection_MGN
//    }
//
//    private static weak var alert_MGN: UIAlertController?
//    private static let queue_MGN = DispatchQueue.global()
//    private static var isAlertPresented_MGN: Bool { alert_MGN != nil }
//
//    private static var _isConnection_MGN: Bool = nwMonitor_MGN.currentPath.status == .satisfied {
//        didSet {
//            if !_isConnection_MGN {
//                print("No internet connection.")
//                showDisconnectionAlert_MGN()
//            } else {
//                print("Internet connection is active.")
//                if isAlertPresented_MGN {
//                    alert_MGN?.dismiss(animated: true)
//                }
//            }
//        }
//    }
//
//    private static let nwMonitor_MGN = {
//        let nwMonitor = NWPathMonitor()
//        nwMonitor.start(queue: queue_MGN)
//        nwMonitor.pathUpdateHandler = { path in
//            DispatchQueue.main.async {
//                _isConnection_MGN = path.status == .satisfied
//            }
//        }
//        return nwMonitor
//    }()
//
//    deinit {
//        NetworkMonitor_MGN.nwMonitor_MGN.cancel()
//    }
//
//    private static func showDisconnectionAlert_MGN() {
//        guard !isAlertPresented_MGN else { return }
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
//        self.alert_MGN = alert
//
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.warning)
//    }
//}
//

