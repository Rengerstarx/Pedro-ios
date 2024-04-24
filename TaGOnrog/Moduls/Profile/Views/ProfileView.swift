//
//  ProfileView.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import SDWebImage
import TinyConstraints

class ProfileView: UIView {
    
    private let photoView = ViewsFactory.defaultImageView(contentMode: .scaleAspectFill)
    private let blurView = ViewsFactory.defaultImageView(contentMode: .scaleAspectFill)
    private let cardView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 6)
    private let tagsView = ViewsFactory.defaultStackView(axis: .horizontal, spacing: 5, alignment: .leading)
    private let tagsView2 = ViewsFactory.defaultStackView(axis: .horizontal, spacing: 5, alignment: .leading)
    private let swipeView = UIView()
    
    private let jobTitle = ViewsFactory.defaultLabel(lines: 1, textColor: .appBlack, font: .sFProText(ofSize: 14))
    private let fioTitle = ViewsFactory.defaultLabel(lines: 1, textColor: .appBlack, font: .sFProTextBold(ofSize: 20))
    private let descriptionTitle = ViewsFactory.defaultLabel(lines: 0, textColor: .appBlack, font: .sFProTextSemibold(ofSize: 14))
    
    var handlerSwipe: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: ProfileModel) {
        photoView.sd_setImage(with: model.photo)
        jobTitle.text = model.vacation
        fioTitle.text = "\(model.firstName) \(model.lastName)"
        descriptionTitle.text = model.aboutMe
        
        var i = 0
        while i < 4 {
            if i < model.tags.count {
                let tag = model.tags[i]
                let tagElement = ViewsFactory.tagView(color: .hexFFDD00, text: tag?.name ?? "")
                tagElement.height(25)
                tagsView.addArrangedSubview(tagElement)
            }
            i += 1
        }
        while i < 7 {
            if i < model.tags.count {
                let tag = model.tags[i]
                let tagElement = ViewsFactory.tagView(color: .hexFFDD00, text: tag?.name ?? "")
                tagElement.height(25)
                tagsView2.addArrangedSubview(tagElement)
            }
            i += 1
        }
    }
    
    private func setupViews() {
        backgroundColor = .appWhite
        photoView.sizeToFit()
        photoView.size(CGSize(width: Constants.screenWidth, height: Constants.screenHeight * 0.7))
        photoView.layer.cornerRadius = 54
        photoView.layer.masksToBounds = true
        photoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        cardView.layer.cornerRadius = 17
        cardView.layer.borderColor = UIColor.hexFFDD00.cgColor
        cardView.layer.borderWidth = 1
        cardView.backgroundColor = .appWhite
        cardView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cardView.isLayoutMarginsRelativeArrangement = true

        blurView.image = AppImage.profileBlur.uiImage
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .up
        swipeView.addGestureRecognizer(swipeGesture)
    }
    
    private func setupLayouts() {
        [photoView, cardView, tagsView, tagsView2].forEach { addSubview($0) }
        [jobTitle, fioTitle, descriptionTitle].forEach { cardView.addArrangedSubview($0) }
        photoView.addSubview(blurView)
        photoView.edgesToSuperview(excluding: .bottom)
        blurView.edgesToSuperview(excluding: .top)
        
        cardView.size(CGSize(width: 334, height: 158))
        cardView.edgesToSuperview(excluding: .bottom, insets: TinyEdgeInsets(top: Constants.screenHeight * 0.6, left: 20, bottom: 0, right: 20))
        
        tagsView.topToBottom(of: cardView, offset: 10)
        tagsView.leadingToSuperview(offset: 20)
        tagsView2.topToBottom(of: tagsView, offset: 5)
        tagsView2.leadingToSuperview(offset: 20)

        cardView.addSubview(swipeView)
        swipeView.edgesToSuperview()
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            handlerSwipe?()
        }
    }
    
}
