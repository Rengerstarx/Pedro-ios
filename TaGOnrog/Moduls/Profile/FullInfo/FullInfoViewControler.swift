//
//  FullInfoViewControler.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation
import UIKit
import TinyConstraints

class FullInfoViewControler: UIViewController {
    
    private let parentStackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 8)
    
    private let imageViewDemoOne = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.demoImageOne.uiImage)
    private let imageViewDemoTwo = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.demoImageTwo.uiImage)

    private let headers = [
        "Имя Фамилия",
        "Почта",
        "День рождения",
        "Должность",
        "Обо мне"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = .appWhite
    }
    
    private func setupLayouts() {
        view.addSubview(parentStackView)
        view.addSubview(imageViewDemoOne)
        view.addSubview(imageViewDemoTwo)
        
        parentStackView.edgesToSuperview(excluding: .bottom, insets: .uniform(8))
        
        imageViewDemoOne.leftToSuperview(offset: 15)
        imageViewDemoOne.bottomToSuperview(offset: -15)
        imageViewDemoOne.topToBottom(of: parentStackView, offset: 15)
        
        imageViewDemoTwo.rightToSuperview(offset: -15)
        imageViewDemoTwo.bottomToSuperview(offset: -15)
        imageViewDemoTwo.topToBottom(of: parentStackView, offset: 15)
    }
    
    func setup(model: ProfileModel) {
        headers.forEach { header in
            let stack = ViewsFactory.defaultStackView(axis: .vertical, spacing: 5)
            let titleLabel = ViewsFactory.defaultLabel(textColor: .appSystemGray, font: .sFProText(ofSize: 13))
            titleLabel.text = header
            let textView = getTextView()
            textView.text = model.getData(key: header)
            if header != "Обо мне" { textView.height(45) }
            else { textView.height(250) }
            [titleLabel, textView].forEach {stack.addArrangedSubview($0)}
            parentStackView.addArrangedSubview(stack)
        }
    }
    
    private func getTextView() -> UITextView {
        let view = UITextView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexFFDD00.cgColor
        view.font = .sFProTextSemibold(ofSize: 18)
        view.backgroundColor = .appWhite
        view.textColor = .appBlack
        view.contentInset = .uniform(2)
        view.textAlignment = .left
        view.contentOffset.y = (view.contentSize.height - view.frame.height) / 2
        view.isEditable = false
        return view
    }
    
}

