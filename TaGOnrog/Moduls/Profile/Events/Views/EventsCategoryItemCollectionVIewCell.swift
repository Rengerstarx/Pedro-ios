//
//  AiChatQuestionsCategoryItemCollectionVIewCell.swift
//  Translator
//
//  Created by tpe on 30.10.2023.
//

import TinyConstraints
import Combine

class EventsCategoryItemCollectionVIewCell: UICollectionViewCell {
    
    private let iconLabel = ViewsFactory.defaultLabel(font: .sFProText(ofSize: 32), adjustFont: true)
    
    private let titleLabel = ViewsFactory.defaultLabel(textColor: .appBlack, adjustFont: true)
    private let descriptionLabel = ViewsFactory.defaultLabel(lines: 2, textColor: .appSystemGray, font: .sFProText(ofSize: 15), adjustFont: true)
    
    private let topStackView = ViewsFactory.defaultStackView(axis: .horizontal)
    
    let action = PassthroughSubject<Void, Never>()
    var observable: AnyCancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func update(item: EventsCategoryItem) {
        iconLabel.text = item.icon
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
    // MARK: - Helpers
    
    private func commonInit() {
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .appWhite
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    private func setupLayout() {
        [iconLabel].forEach { topStackView.addArrangedSubview($0) }
        [topStackView, titleLabel, descriptionLabel].forEach { contentView.addSubview($0) }
        
        let horizontalInsets = TinyEdgeInsets.horizontal(10)
        
        topStackView.topToSuperview(offset: 8)
        topStackView.horizontalToSuperview(insets: horizontalInsets)
        
        titleLabel.topToBottom(of: topStackView)
        titleLabel.horizontalToSuperview(insets: horizontalInsets)
        
        descriptionLabel.topToBottom(of: titleLabel)
        descriptionLabel.horizontalToSuperview(insets: horizontalInsets)
    }
    
    // MARK: - Handlers
    
    @objc private func startChatButtonPressed() {
        action.send()
    }
    
}
