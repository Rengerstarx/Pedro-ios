//
//  RootTabBarViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 31.01.2024.
//

import UIKit
import TinyConstraints

fileprivate extension RootTabBarItem {
    
    var viewController: UIViewController {
        switch self {
        case .dating:
            return DatingViewController()
        case .search:
            return AllChatsViewController()
        case .profile:
            return ProfileViewController()
        }
    }
    
}

class RootTabBarViewController: UITabBarController {
    
    private let tabBarItemsView = RootTabBarItemsView()
    
    private(set) var bannerHeight: CGFloat = 0
    private var bannerViewBottom: NSLayoutConstraint?
    
    private(set) var selectedTabBarItem = RootTabBarItem.dating
        
    private var pushedControllerHidesBottomBarWhenPushed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupLayout()
        setupHandlers()
        selectTabBarItem(.dating)
    }
    
    func selectTabBarItem(_ tabBarItem: RootTabBarItem) {
        selectedIndex = tabBarItem.rawValue
        tabBarItemsView.setSelectedTabItem(tabBarItem)
        selectedTabBarItem = tabBarItem
    }
    
    // MARK: - Helpers
    
    private func setupViewControllers() {
        let controllers = RootTabBarItem.allCases.map { $0.viewController }
        viewControllers = controllers.map { controller in
            let navigation = AppNavigationController(rootViewController: controller)
            navigation.delegate = self
            return navigation
        }
    }
    
    private func setupLayout() {
        tabBar.addSubview(tabBarItemsView)
        tabBarItemsView.edgesToSuperview()
    }
    
    private func setupHandlers() {
        tabBarItemsView.handleTabBarItemSelected = { [weak self] tabBarItem in
            if self?.selectedTabBarItem == tabBarItem {
                let navVc = self?.selectedViewController as? UINavigationController
                navVc?.popToRootViewController(animated: true)
            } else {
                self?.selectTabBarItem(tabBarItem)
            }
        }
    }
    
}

// MARK: - UINavigationControllerDelegate

extension RootTabBarViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard selectedViewController == navigationController else { return }
        guard pushedControllerHidesBottomBarWhenPushed != viewController.hidesBottomBarWhenPushed else { return }
        pushedControllerHidesBottomBarWhenPushed = viewController.hidesBottomBarWhenPushed
//        UIView.animate(withDuration: 0.1) { [weak self] in
//            self?.bannerView?.superview?.layoutIfNeeded()
//        }
    }

}

extension UIViewController {

    var rootTabBarController: RootTabBarViewController? {
        return tabBarController as? RootTabBarViewController
    }

}
