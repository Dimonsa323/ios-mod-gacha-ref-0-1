//
//  Utilities.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 23.01.2024.
//

import SwiftUI
import Resolver
import HYSLogger

final class IMGR_Utilities {

    @Injected private var networkMonitoringManager: IMGR_NetworkMonitoringManager
    
    static let shared = IMGR_Utilities()
    private init() {}

    func IMGR_retrowFunction(action: IMGR_AsyncEmptyClosure) async {
        while true {
            do {
                try Task.checkCancellation()

                if networkMonitoringManager.IMGR_isReachable() {
                    await action()
                  return
                }

                try Task.checkCancellation()
                await Task.IMGR_sleep(seconds: 3)
            } catch {
                Logger.error(error)
            }
        }
    }

    func IMGR_retrowThrowsFunction(action: IMGR_AsyncThrowEmptyClosure) async {
        while true {
            do {
                try Task.checkCancellation()

                if networkMonitoringManager.IMGR_isReachable()  {
                    try await action()
                  return
                }

                try Task.checkCancellation()
                await Task.IMGR_sleep(seconds: 2)
            } catch {
                Logger.error(error)
            }
        }
    }

    func IMGR_safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }

        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }

        return safeArea
    }

    func IMGR_aspectRatioForImage(aspectRatio: CGFloat) -> CGFloat {
        let width = UIApplication.IMGR_viewBounds.width
        let height = UIApplication.IMGR_viewBounds.width / aspectRatio
        return width/height
    }

    func IMGR_widthWith(aspectRatio: CGFloat) -> CGFloat {
        return UIApplication.IMGR_viewBounds.width * aspectRatio
    }

    func IMGR_heightWith(aspectRatio: CGFloat) -> CGFloat {
        return UIApplication.IMGR_viewBounds.height * aspectRatio
    }

    func IMGR_widthAspectRatioDevice(width: CGFloat) -> CGFloat {
        if isIPad {
            return UIApplication.IMGR_viewBounds.width * (width / 1024)
        } else {
            return UIApplication.IMGR_viewBounds.width * (width / 390)
        }
    }

    func IMGR_heightAspectRatioDevice(height: CGFloat) -> CGFloat {
        if isIPad {
            return UIApplication.IMGR_viewBounds.height * (height / 1366)
        } else {
            return UIApplication.IMGR_viewBounds.height * (height / 844)
        }
    }

    func IMGR_widthWithOpt(aspectRatio: CGFloat?) -> CGFloat? {
        if let aspectRatio {
            return UIApplication.IMGR_viewBounds.width * aspectRatio
        } else {
            return nil
        }
    }

    func IMGR_heightWithOpt(aspectRatio: CGFloat?) -> CGFloat? {
        if let aspectRatio {
            return UIApplication.IMGR_viewBounds.height * aspectRatio
        } else {
            return nil
        }
    }

    func IMGR_presentActivitySheet(url: URL, rect: CGRect, onDismiss: (() -> Void)? = nil) {
        guard let vc = IMGR_topViewController() else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        activityVC.popoverPresentationController?.sourceView = vc.view
        activityVC.popoverPresentationController?.sourceRect = rect

        activityVC.completionWithItemsHandler = { _, _, _, _ in
           onDismiss?()
        }

        vc.present(activityVC, animated: true, completion: nil)
    }

    func IMGR_presentNoInternetConnectionAllert(action: @escaping IMGR_ValueClosure<UIAlertAction>) -> UIAlertController {
        let alert = UIAlertController(title: "", message: "No Internet connection found", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: action))

        self.IMGR_topViewController()?.present(alert, animated: true, completion: nil)

        return alert
    }

    func IMGR_topViewController(controller: UIViewController? = nil) -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        let controller = controller ?? windowScene.windows.first?.rootViewController

        if let navigationController = controller as? UINavigationController {
            return IMGR_topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return IMGR_topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return IMGR_topViewController(controller: presented)
        }
        return controller
    }
}

// MARK: - Image & PDFImage
extension IMGR_Utilities {
    /// Initializes a SwiftUI `Image` from data.
    func IMGR_getImage(data: Data) -> UIImage? {
        UIImage(data: data)
    }

    func IMGR_getPDFImage(data: Data, size: CGSize, additionalYoffSet: CGFloat?) async -> UIImage? {
        guard
            let provider = CGDataProvider(data: data as CFData),
            let pdfDoc   = CGPDFDocument(provider),
            let pdfPage  = pdfDoc.page(at: 1)
        else { return nil }

        let pageRect = pdfPage.getBoxRect(.mediaBox)
        let scaleH = min(1, size.height / pageRect.height)
        let scaleW = min(1, size.width / pageRect.width)
        let scaleFactor = max(scaleW, scaleH)

        let scaledRect = pageRect.applying(.init(scaleX: scaleFactor, y: scaleFactor))
        let renderer = UIGraphicsImageRenderer(size: scaledRect.size)

        let img = renderer.image { ctx in
            UIColor.clear.set()
            ctx.fill(scaledRect)

            ctx.cgContext.translateBy(x: 0.0, y: scaledRect.size.height - (additionalYoffSet ?? 0))
            ctx.cgContext.scaleBy(x: scaleFactor, y: -scaleFactor)

            ctx.cgContext.drawPDFPage(pdfPage)
        }

        return img
    }

    func IMGR_renderOriginalImage(datas: [Data]) -> UIImage? {
        let pdfPages: [CGPDFPage] = datas.compactMap { data in
            guard
                let provider = CGDataProvider(data: data as CFData),
                let pdfDoc   = CGPDFDocument(provider),
                let pdfPage  = pdfDoc.page(at: 1)
            else {
                return nil
            }
            return pdfPage
        }

        guard !pdfPages.isEmpty else { return nil }

        let pageRect = pdfPages.first!.getBoxRect(.mediaBox)
        
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.clear.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            for pdfPage in pdfPages {
                ctx.cgContext.drawPDFPage(pdfPage)
            }
        }

        return img
    }
}


// MARK: - List
extension IMGR_Utilities {
    func IMGR_saveSavedList(array : [String]) {
        var _IMGR375235: Int { 0 }
        var _IMGR96: Int { 0 }
        var _IMGR9246: Int { 0 }
        if array.count > 0 {
            if let data = try? PropertyListEncoder().encode(array) {
                let defaults = UserDefaults.standard
                defaults.setValue(data, forKey: "saved_list_database")
            }
        } else {
            IMGR_cleanSavedList()
        }
    }

    func IMGR_getSavedList() -> [String] {
        var _IMGR372656: Int { 0 }
        var _IMGR97: Int { 0 }
        var _IMGR97324: Int { 0 }
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "saved_list_database") {
            let array = try! PropertyListDecoder().decode([String].self, from: data)
            return array
        } else {
            return []
        }
    }

    private func IMGR_cleanSavedList() {
        var _IMGR324577: Int { 0 }
        var _IMGR3272357: Int { 0 }
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "saved_list_database")
    }

}

