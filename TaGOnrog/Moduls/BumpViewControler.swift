//
//  BumpViewControler.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import TinyConstraints
import SDWebImage

class BumpViewControler: UIViewController {
    
    private let imageOne = ViewsFactory.defaultImageView(contentMode: .redraw)
    private let imageTwo = ViewsFactory.defaultImageView(contentMode: .redraw)
    private let continueButton = ViewsFactory.continueButton()
    private let imageLike1 = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit)
    private let imageLike2 = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit)
    private let stack = ViewsFactory.defaultStackView(axis: .horizontal, spacing: -30)
    
    var handler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    func setup(_ images: [URL]) {
        imageOne.sd_setImage(with: images[0])
        imageTwo.sd_setImage(with: images[1])
        imageLike1.image = AppImage.like.uiImage
        imageLike2.image = AppImage.like.uiImage
    }
    
    private func setupViews() {
        view.backgroundColor = .hexFFDD00
        continueButton.setTitle("Пообщаться", for: .normal)
        continueButton.setTitleColor(.appWhite, for: .normal)
        continueButton.backgroundColor = .appBlack
        continueButton.layer.cornerRadius = 26
        
        imageOne.sizeToFit()
        imageTwo.sizeToFit()
        imageLike1.sizeToFit()
        imageLike2.sizeToFit()
        
        imageOne.size(CGSize(width: 150, height: 270))
        imageTwo.size(CGSize(width: 150, height: 270))
        imageLike1.size(CGSize(width: 58, height: 58))
        imageLike2.size(CGSize(width: 58, height: 58))
        
        imageOne.layer.cornerRadius = 16
        imageOne.layer.masksToBounds = true
        imageTwo.layer.cornerRadius = 16
        imageTwo.layer.masksToBounds = true
        
        continueButton.addTarget(self, action: #selector(bump), for: .touchUpInside)

    }
    
    private func setupLayouts() {
        [stack, continueButton,imageLike1,imageLike2].forEach { view.addSubview($0) }
        continueButton.edgesToSuperview(excluding: .top, insets: .horizontal(20) + .bottom(60))
        stack.centerInSuperview()
        stack.addArrangedSubview(imageOne)
        stack.addArrangedSubview(imageTwo)
        
        imageTwo.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 32)
        imageOne.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 32)
        
        imageLike1.bottomToTop(of: stack, offset: 50)
        imageLike2.leftToSuperview(offset: 100)
        imageLike1.rightToSuperview(offset: -120)
        imageLike2.topToBottom(of: stack, offset: -50)
    }
    
    @objc private func bump() {
        handler?()
    }

    
}
