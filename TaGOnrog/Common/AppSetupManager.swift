//
//  AppSetupManager.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints

class AppSetupManager {

    class func setup() {
        setupAppearance()
    }
    
    // MARK: - Helpers
    
    private class func setupAppearance() {
        let color = UIColor.appWhite
        let navAppearance = UINavigationBarAppearance(transparent: false, color: color)
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().tintColor = .hexFFDD00
        
        let toolbarApperance = UIToolbarAppearance()
        toolbarApperance.backgroundColor = .appWhite
        UIToolbar.appearance().standardAppearance = toolbarApperance
        if #available(iOS 15.0, *) {
            UIToolbar.appearance().scrollEdgeAppearance = toolbarApperance
        }
        UIToolbar.appearance().tintColor = .hexFFDD00
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.backgroundColor = color
        UITabBar.appearance().standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
    }
    
}
