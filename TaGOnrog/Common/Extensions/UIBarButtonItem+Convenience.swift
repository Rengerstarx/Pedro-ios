//
//  UIBarButtonItem+Convenience.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit

extension UIBarButtonItem {
    
    static func space() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    func addTarget(_ target: AnyObject?, action: Selector?) {
        self.target = target
        self.action = action
    }
    
}
