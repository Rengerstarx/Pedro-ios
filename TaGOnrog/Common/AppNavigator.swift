//
//  AppNavigator.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints

class AppNavigationController: UINavigationController {
    
    private let defaultStatusBarStyle = UIStatusBarStyle.darkContent
    private lazy var statusBarStyle = defaultStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setDefaultStatusBarStyle() {
        statusBarStyle = defaultStatusBarStyle
        setNeedsStatusBarAppearanceUpdate()
    }
    
}

class AppNavigator {
    
    static let shared = AppNavigator()
    
    private(set) var window: UIWindow?
    
    var topViewController: UIViewController? {
        return window?.rootViewController?.topViewController()
    }
    
    func setupRootNavigationInWindow(_ window: UIWindow?) {
        self.window = window
    }

    // MARK: - Helpers
    
    private func showRootTabBarController() {
        window?.rootViewController = RootTabBarViewController()
    }

}
