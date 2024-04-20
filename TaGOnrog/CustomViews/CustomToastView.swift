//
//  CustomToastView.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit

class CustomToastView: UIView {
    
    private let size = CGSize(width: 250, height: 45)
    private let label = ViewsFactory.defaultLabel(lines: 2, textColor: .appWhite, font: .sFProText(ofSize: 15), adjustFont: true)
    
    init(image: AppImage? = nil, message: String) {
        super.init(frame: CGRect(origin: .zero, size: size))
        backgroundColor = .appWhite
        layer.cornerRadius = size.height / 2
        addShadowWithColor(.appBlack, opacity: 0.15, offset: CGSize(width: 0, height: 4), radius: 10)
        
        addSubview(label)
        label.centerYToSuperview()
        label.horizontalToSuperview(insets: .horizontal(16))
        label.textAlignment = .center
        
        label.attributedText = {
            let font = UIFont.sFProTextSemibold(ofSize: 11)
            let color = UIColor.appBlack
            
            let attributedString = NSAttributedString(
                string: message,
                attributes: [.font: font, .foregroundColor: color]
            )
            guard let image = image?.uiImageWith(font: font, tint: color) else { return attributedString }
            let attachment = NSTextAttachment()
            attachment.image = image
            let attachmentString = NSAttributedString(attachment: attachment)
            
            let spaceString = NSAttributedString(string: " ", attributes: [.font: font])
            
            let mutableString = NSMutableAttributedString()
            [attachmentString, spaceString, attributedString].forEach { mutableString.append($0) }
            return mutableString
        }()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
