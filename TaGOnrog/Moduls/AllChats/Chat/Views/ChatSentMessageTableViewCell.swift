import UIKit
import TinyConstraints
import Combine

struct ChatMessageCellConstants {
    let horizontalOffset: CGFloat = 12
    let verticalOffset: CGFloat = 10
    let cornerRadius: CGFloat = 18
}

class ChatSentMessageTableViewCell: UITableViewCell {
    
    private let messageTextLabel = ViewsFactory.defaultLabel(lines: 0)
    private let messageView = UIView()
    
    private let tailImageView = ViewsFactory.defaultImageView()
    
    private let cellConstants = ChatMessageCellConstants()
    
    private let stackView = ViewsFactory.defaultStackView(axis: .horizontal, spacing: 3)
    private let parentStackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 2)
    
    var observable: AnyCancellable?
    let action = PassthroughSubject<Void, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func update(cell: ChatSentMessageCell) {
        messageTextLabel.text = cell.message
    }
    
    // MARK: - Helpers
    
    private func commonInit() {
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        parentStackView.backgroundColor = .hexFFDD00
        parentStackView.layer.cornerRadius = cellConstants.cornerRadius
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        tailImageView.image = AppImage.aiChatSentMessageTail.uiImage
    }
    
    private func setupLayout() {
        messageView.addSubview(messageTextLabel)
        messageTextLabel.edgesToSuperview(insets: TinyEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        
        [messageView].forEach { parentStackView.addArrangedSubview($0) }
                
        [tailImageView, parentStackView].forEach { contentView.addSubview($0) }
        
        parentStackView.trailingToSuperview(offset: cellConstants.horizontalOffset)
        parentStackView.widthToSuperview(multiplier: 267 / 375)
        parentStackView.verticalToSuperview(insets: .vertical(cellConstants.verticalOffset))
        
        tailImageView.bottom(to: parentStackView)
        tailImageView.trailing(to: parentStackView, offset: 4)
    }
    
    @objc private func documentButtonTapped() {
        action.send()
    }
    
}
