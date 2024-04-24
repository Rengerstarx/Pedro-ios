//
//  AppDelegate.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 31.01.2024.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AppSetupManager.setup()
        window = UIWindow(frame: UIScreen.main.bounds)
//        AppNavigator.shared.setupRootNavigationInWindow(window)
        window?.rootViewController = RootTabBarViewController()
//        window?.rootViewController = RegistrationViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
}
