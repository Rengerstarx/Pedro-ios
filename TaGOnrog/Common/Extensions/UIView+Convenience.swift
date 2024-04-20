//
//  UIView+Convenience.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import Toast_Swift

extension UIView {
    
    func getSuperview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.getSuperview(of: type)
    }
    
    func findViewByString(_ classString: String) -> UIView? {
        for subview in subviews {
            if NSStringFromClass(type(of: subview)) == classString {
                return subview
            }
            if let view = subview.findViewByString(classString) {
                return view
            }
        }
        return nil
    }
    
    func addShadowWithColor(_ color: UIColor = .appBlack, opacity: Float, offset: CGSize = .zero, radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.rasterizationScale = Constants.screenScale
        layer.shouldRasterize = true
    }
    
    func showToastWithText(_ text: String, image: AppImage? = nil, completion: ((Bool) -> Void)? = nil) {
        hideAllToasts()
        let view = CustomToastView(image: image, message: text)
        showToast(view, position: .top, completion: completion)
    }
    
    func calculateFrameOnScreen(calculatedFrame: CGRect? = nil, in view: UIView? = nil) -> CGRect {
        var frame = calculatedFrame ?? frame
        guard let superView = superview, let superSuperView = superView.superview else {
            return frame
        }
        frame = superView.convert(frame, to: superSuperView)
        if superView == view {
            return frame
        }
        return superView.calculateFrameOnScreen(calculatedFrame: frame, in: view)
    }
    
    @objc func hideKeyboard() {
        endEditing(true)
    }
    
}
