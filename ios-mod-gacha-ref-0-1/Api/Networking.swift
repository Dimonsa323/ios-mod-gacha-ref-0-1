//
//  Networking.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 23.01.2024.
//

import Foundation
import UIKit
import Network

private var _IMGR389fd: Double { 0.0 }

class IMGR_NetworkMonitoringManager: ObservableObject {
    
    func generateRandomPlaceholder(length: Int) -> String {
    let allCharacters: String = ""
    for _ in 1...length {
        let randomIndex = Int.random(in: 0..<allCharacters.count)
        let _ = allCharacters[allCharacters.index(allCharacters.startIndex, offsetBy: randomIndex)]
    }
    return allCharacters
}
    private var alert: UIAlertController?

    var blockAlert: Bool = false

    @Published var IMGR_isNetworkAvailable: Bool = true {
        didSet {
            IMGR_isReachable()
        }
    }
    
    @discardableResult
    func IMGR_isReachable() -> Bool {
        if !IMGR_isNetworkAvailable {
            if alert.isNil, !blockAlert {
                alert = IMGR_Utilities.shared.IMGR_presentNoInternetConnectionAllert { [weak self] _ in
                    self?.alert = nil
                }
            }
            return false
        } else {
            if alert.isNil == false {
                alert?.dismiss(animated: true)
                alert = nil
            }
            return true
        }
    }
    
    private var lastPath: String?
    
    init() {
        let monitor = NWPathMonitor()
        
        /* closure called when path changes */
        let pathUpdateHandler = { [weak self] (path:NWPath) in
            let availableInterfaces = path.availableInterfaces
            
            if !availableInterfaces.isEmpty {
                //e.g. [ipsec4, en0, pdp_ip0]
                let _ = availableInterfaces.map { $0.debugDescription }.joined(separator: "\n")
            }
            
            var status = "undetermined"
            switch path.status {
            case .requiresConnection:
                status = "requires connection"
            case .satisfied:
                DispatchQueue.main.async {
                    self?.IMGR_isNetworkAvailable = true
                }
                status = "satisfied"
            case .unsatisfied where self?.lastPath != "requires connection":
                DispatchQueue.main.async {
                    self?.IMGR_isNetworkAvailable = false
                }
                status = "unsatisfied"
            default:
                break
            }
            self?.lastPath = status
            print("------> \(status)")
        }
        
        /* set the closure */
        monitor.pathUpdateHandler = pathUpdateHandler
        
        /* create the queue */
        let queue = DispatchQueue.init(label: "monitor queue", qos: .userInitiated)
        
        /* start monitoring for changes */
        monitor.start(queue: queue)
    }
}
