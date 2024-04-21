//
//  AllChatCollectionViewCell.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import TinyConstraints
import SDWebImage

class AllChatCollectionViewCell: UICollectionViewCell {
    
    private let lastMessage = ViewsFactory.defaultLabel(lines: 1, textColor: .appSystemGray, font: .sFProText(ofSize: 14))
    private let lastMessageTime = ViewsFactory.defaultLabel(lines: 1, textColor: .appSystemGray, font: .sFProText(ofSize: 14), alignment: .right)
    private let nameMessage = ViewsFactory.defaultLabel(lines: 1, textColor: .appBlack, font: .sFProTextSemibold(ofSize: 18))
    private let line = ViewsFactory.separatorLine(color: .hexFFDD00, vertical: false, thickness: 1)
    private let photoView = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit)
    
    var handler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: ChatModel) {
        lastMessage.text = model.lastMessageText
        nameMessage.text = model.name
        lastMessageTime.text = model.lastMessageTimeText
        photoView.sd_setImage(with: model.photo)
    }
    
    private func setupViews() {
        backgroundColor = .appWhite
        
        photoView.size(CGSize(width: 48, height: 48))
        photoView.layer.cornerRadius = 24
        photoView.layer.borderWidth = 2
        photoView.layer.borderColor = UIColor.hexFFDD00.cgColor
        photoView.clipsToBounds = true
        photoView.sizeToFit()
    }
    
    private func setupLayouts() {
        [photoView, lastMessage, nameMessage, line, lastMessageTime].forEach { addSubview($0) }
        photoView.centerYToSuperview()
        photoView.leftToSuperview(offset: 10)
        
        nameMessage.topToSuperview(offset: 5)
        nameMessage.leftToRight(of: photoView, offset: 10)
        lastMessage.topToBottom(of: nameMessage, offset: 5)
        lastMessage.leftToRight(of: photoView, offset: 10)
        
        lastMessageTime.topToBottom(of: nameMessage, offset: 5)
        lastMessageTime.rightToSuperview(offset: -5)
        
        lastMessage.rightToLeft(of: lastMessageTime, offset: -5)
        
        line.edgesToSuperview(excluding: .top)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))

        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(tapGesture)

    }
 
    @objc func imageTapped() {
        handler?()
    }
    
}
