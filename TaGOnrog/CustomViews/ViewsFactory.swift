//
//  ViewsFactory.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 31.01.2024.
//

import TinyConstraints
import UIKit

class ViewsFactory {
    
    class func defaultButton(
        type: UIButton.ButtonType = .system,
        height: CGFloat? = nil,
        color: UIColor,
        radius: CGFloat = 0,
        font: UIFont,
        titleColor: UIColor = .appWhite
    ) -> UIButton {
        let button = UIButton(type: type)
        if let height = height {
            button.height(height)
        }
        button.backgroundColor = color
        button.layer.cornerRadius = radius
        button.titleLabel?.font = font
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    class func defaultLabel(
        lines: Int = 1,
        textColor: UIColor = .appBlack,
        font: UIFont = .sFProText(ofSize: 17),
        alignment: NSTextAlignment = .natural,
        adjustFont: Bool = false,
        alpha: CGFloat = 1.0
    ) -> UILabel {
        let label = UILabel()
        label.numberOfLines = lines
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        label.alpha = alpha
        if adjustFont {
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
        }
        return label
    }
    
    class func defaultImageView(
        contentMode: UIView.ContentMode = .scaleAspectFit,
        image: UIImage? = nil
    ) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        return imageView
    }
    
    class func defaultScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        return scrollView
    }
    
    class func defaultStackView(
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        margins: TinyEdgeInsets? = nil
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = alignment
        if let margins = margins {
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = margins
        }
        return stackView
    }
    
    class func separatorLine(color: UIColor = .appBlack, vertical: Bool = true, thickness: CGFloat = 1) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        if vertical {
            line.width(thickness)
        } else {
            line.height(thickness)
        }
        return line
    }
    
    class func defaultActivityIndicator(style: UIActivityIndicatorView.Style = .medium, color: UIColor = .appSystemGray) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }
    
    class func defaultBarButton(font: UIFont = .sFProText(ofSize: 17), image: AppImage? = nil, color: UIColor = .hexFFDD00) -> UIBarButtonItem {
        let button = UIBarButtonItem()
        [.normal, .highlighted].forEach { state in
            button.setTitleTextAttributes([.font: font, .foregroundColor: color], for: state)
        }
        button.setTitleTextAttributes([.font: font, .foregroundColor: color.withAlphaComponent(0.2)], for: .disabled)
        button.image = image?.uiImageWith(font: font, tint: color)
        return button
    }
    
    class func defaultSwitch(tintColor: UIColor = .hexFFDD00) -> UISwitch {
        let switchView = UISwitch()
        switchView.onTintColor = tintColor
        return switchView
    }
    
    class func defaultStepper(tintColor: UIColor = .white) -> UIStepper {
        let stepperView = UIStepper()
        stepperView.tintColor = tintColor
        return stepperView
    }
    
    class func continueButton() -> UIButton {
        return defaultButton(
            height: 56,
            color: .hexFFDD00,
            radius: 14,
            font: .sFProTextSemibold(ofSize: 20),
            titleColor: .appWhite
        )
    }
    
    class func tagView(color: UIColor, text: String) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = color
        let lable = ViewsFactory.defaultLabel(lines: 1, textColor: .appBlack, font: .sFProTextBold(ofSize: 12))
        view.addSubview(lable)
        lable.text = text
        lable.edgesToSuperview(insets: .uniform(5))
        return view
    }
    
}
