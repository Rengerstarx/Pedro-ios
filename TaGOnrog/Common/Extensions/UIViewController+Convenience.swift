//
//  UIViewController+Convenience.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import PKHUD
import SafariServices
import TinyConstraints

extension UIViewController {
    
    var isViewVisible: Bool {
        return isViewLoaded && view.window != nil
    }
    
    func topViewController() -> UIViewController {
        if let controller = (self as? UINavigationController)?.visibleViewController {
            return controller.topViewController()
        } else if let controller = (self as? UITabBarController)?.selectedViewController {
            return controller.topViewController()
        } else if let controller = presentedViewController {
            return controller.topViewController()
        }
        return self
    }
    
    func showHUD() {
        HUD.show(.progress)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func applyDefaultAppearance() {
        let apperance = UINavigationBar.appearance()
        navigationItem.standardAppearance = apperance.standardAppearance
        navigationItem.scrollEdgeAppearance = apperance.scrollEdgeAppearance
    }
    
    func applyTransparentAppearance(color: UIColor = .appClear, titleColor: UIColor = .appBlack) {
        let appearance = UINavigationBarAppearance(transparent: true, color: color, titleColor: titleColor)
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func openLinkURL(_ link: URL) {
        let vc = SFSafariViewController(url: link)
        present(vc, animated: true)
    }
    
    func setBackButtonTitle() {
        navigationItem.backButtonTitle = "^String.ButtonTitles.backButtonTitle"
    }
    
//    func printFile(_ file: URL) {
//        if UIPrintInteractionController.canPrint(file) {
//            let printInfo = UIPrintInfo(dictionary: nil)
//            printInfo.jobName = file.lastPathComponent
//            printInfo.outputType = .general
//            
//            let printController = UIPrintInteractionController.shared
//            printController.printInfo = printInfo
//            printController.showsNumberOfCopies = true
//            printController.printingItem = file
//            printController.present(animated: true, completionHandler: nil)
//        }
//    }
    
//    func showToast(title: String) {
//        let toastView = WhiteToastView()
//        toastView.setTitle(title)
//        let yOffset = view.frame.height - view.safeAreaInsets.bottom - 16 - toastView.viewHeight / 2
//        let point = CGPoint(x: view.center.x, y: yOffset)
//        view.showToast(toastView, point: point)
//    }
    
}
