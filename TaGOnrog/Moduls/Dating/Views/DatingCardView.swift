//
//  DatingCardView.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints
import Shuffle_iOS

class DatingCardView: SwipeCard {
    
    private let cardContent = UIView()
    private let stackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 10, alignment: .top)
    private let aboutMeLabel = ViewsFactory.defaultLabel(lines: 0, textColor: .appBlack)
    private let tagsStack = ViewsFactory.defaultStackView(axis: .vertical, spacing: 10, alignment: .top)
    private let aboutMeTitle = ViewsFactory.defaultLabel(textColor: .appBlack, font: .sFProTextBold(ofSize: 24))
    private let line = ViewsFactory.separatorLine(color: .hexFFDD00, vertical: false, thickness: 1)
    private let line2 = ViewsFactory.separatorLine(color: .hexFFDD00, vertical: false, thickness: 1)
    
    private let imageLike = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.likeImageMatch.uiImage)
    private let imageDislike = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.dislikeImageMatch.uiImage)
    
    var hadler: ((Bool) -> Void)?
    
    func setup(model: DatingModel) {
        setupViews(model: model)
        setupLayouts()
        setupSwipeSettings()
    }
    
    private func setupViews(model: DatingModel) {
        aboutMeLabel.text = model.aboutMe
        aboutMeTitle.text = "Обо мне:"
        
        cardContent.backgroundColor = .appWhite
        cardContent.layer.borderColor = UIColor.hexFFDD00.cgColor
        cardContent.layer.borderWidth = 2
        cardContent.layer.cornerRadius = 16
        
        imageLike.size(CGSize(width: 56, height: 56))
        imageDislike.size(CGSize(width: 56, height: 56))
        line.size(CGSize(width: 156, height: 1))
        line2.size(CGSize(width: Constants.screenWidth, height: 1))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTappedLike(_:)))
        imageLike.isUserInteractionEnabled = true
        imageLike.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizerDis = UITapGestureRecognizer(target: self, action: #selector(imageViewTappeddisDislike(_:)))
        imageDislike.isUserInteractionEnabled = true
        imageDislike.addGestureRecognizer(tapGestureRecognizerDis)
    }
    
    private func setupLayouts() {
        [aboutMeTitle, line, aboutMeLabel, line2].forEach { stackView.addArrangedSubview($0) }
        [stackView, imageLike, imageDislike].forEach { addSubview($0) }
        
        stackView.edgesToSuperview(excluding: .bottom, insets: .uniform(14))
        imageLike.leftToSuperview(offset: 20)
        imageDislike.rightToSuperview(offset: -20)
        
        imageLike.bottomToSuperview(offset: -20)
        imageDislike.bottomToSuperview(offset: -20)
    }
    
    private func setupSwipeSettings() {
        swipeDirections = [.left, .right]
        content = cardContent
        
        let leftOverlay = UIView()
        let imageLikeView = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.likeImage.uiImage)
        imageLikeView.size(CGSize(width: 200, height: 100))
        leftOverlay.addSubview(imageLikeView)
        imageLikeView.topToSuperview(offset: 10)
        imageLikeView.rightToSuperview(offset: -10)
        leftOverlay.backgroundColor = .appSystemGreen.withAlphaComponent(0.2)
        leftOverlay.layer.cornerRadius = 16
        
        let rightOverlay = UIView()
        let imageDislikeView = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.dislikeImage.uiImage)
        imageDislikeView.size(CGSize(width: 200, height: 100))
        rightOverlay.addSubview(imageDislikeView)
        imageDislikeView.topToSuperview(offset: 10)
        imageDislikeView.leftToSuperview(offset: 10)
        rightOverlay.backgroundColor = .appSystemRed.withAlphaComponent(0.2)
        rightOverlay.layer.cornerRadius = 16
        
        setOverlays([.left: leftOverlay, .right: rightOverlay])
    }
    
    @objc private func imageViewTappedLike(_ sender: UITapGestureRecognizer) {
        hadler?(true)
    }
    
    @objc private func imageViewTappeddisDislike(_ sender: UITapGestureRecognizer) {
        hadler?(false)
    }
    
}
