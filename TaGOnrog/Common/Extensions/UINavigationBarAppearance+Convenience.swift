//
//  UINavigationBarAppearance+Convenience.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints

extension UINavigationBarAppearance {
    
    convenience init(transparent: Bool, color: UIColor, titleColor: UIColor = .appBlack) {
        self.init()
        if transparent {
            configureWithTransparentBackground()
        }
        backgroundColor = color
        titleTextAttributes = [.font: UIFont.sFProTextBold(ofSize: 17), .foregroundColor: titleColor]
        largeTitleTextAttributes = [.font: UIFont.sFProTextBold(ofSize: 34), .foregroundColor: titleColor]
        
        let button = UIBarButtonItemAppearance()
        [button.normal, button.highlighted].forEach {
            $0.titleTextAttributes = [.foregroundColor: UIColor.hexFFDD00, .font: UIFont.sFProText(ofSize: 17)]
        }
        backButtonAppearance = button
    }
    
}
