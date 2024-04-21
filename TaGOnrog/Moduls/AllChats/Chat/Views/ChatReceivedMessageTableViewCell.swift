import TinyConstraints
import Combine
import AMPopTip
import SDWebImage

class ChatReceivedMessageTableViewCell: UITableViewCell {
    
    enum Action {
        case copyMessage
    }
    
    private let avatarImageView = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit)
    private let avatarImageViewWrapper = UIView()
    private let avatarImageSize: CGFloat = 41
    
    private let messageTextLabel = ViewsFactory.defaultLabel(lines: 0, textColor: .appBlack)
    private let messageView = UIView()
    
    private let copyButton = UIButton()
        
    private let buttonFont = UIFont.sFProText(ofSize: 14)
    private let buttonTint = UIColor.hexFFDD00
    private let buttonBackgroundAlpha: CGFloat = 0.1
    
    private let buttonsStackView = ViewsFactory.defaultStackView(spacing: 12)
    private let buttonHeight: CGFloat = 32
    
    private let messageStackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 5, alignment: .trailing)
    
    private let tailImageView = ViewsFactory.defaultImageView()
    
    private let parentStackView = ViewsFactory.defaultStackView(spacing: 8, alignment: .top)
    
    private let cellConstants = ChatMessageCellConstants()
    
    private var isSpeaking = false
    
    private let bodyView = UIView()
    
    var observable: AnyCancellable?
    let action = PassthroughSubject<Action, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if buttonForPoint(point) != nil {
            return true
        }
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let button = buttonForPoint(point) {
            return button
        }
        return super.hitTest(point, with: event)
    }
    
    func update(cell: ChatReceivedMessageCell, photo: URL?) {
        messageTextLabel.text = cell.message
        bodyView.addSubview(messageView)
        messageView.edgesToSuperview()
        
        messageStackView.addArrangedSubview(buttonsStackView)
        
        if let url = photo { avatarImageView.sd_setImage(with: url) }
    }

    // MARK: - Helpers
    
    private func commonInit() {
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        avatarImageView.image = AppImage.aiChatRobotIcon.uiImage
        avatarImageViewWrapper.backgroundColor = .hexEEEEFB
        avatarImageViewWrapper.layer.cornerRadius = avatarImageSize / 2
        
        bodyView.backgroundColor = .hexFFDD00
        bodyView.layer.cornerRadius = cellConstants.cornerRadius
                
        copyButton.setImage(AppImage.filesDocOnDoc.uiImageWith(font: buttonFont, tint: buttonTint), for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonPressed), for: .touchUpInside)
        
        let buttonRadius = buttonHeight / 2
        [copyButton].forEach { button in
            button.backgroundColor = buttonTint.withAlphaComponent(buttonBackgroundAlpha)
            button.layer.cornerRadius = buttonRadius
            button.clipsToBounds = true
        }
        
        tailImageView.image = AppImage.aiChatReceivedMessageTail.uiImage
    }
    
    private func setupLayout() {
        avatarImageView.sizeToFit()
        avatarImageView.size(CGSize(width: avatarImageSize, height: avatarImageSize))
        avatarImageViewWrapper.addSubview(avatarImageView)
        avatarImageViewWrapper.clipsToBounds = true
        avatarImageView.centerInSuperview()
        avatarImageViewWrapper.size(CGSize(width: avatarImageSize, height: avatarImageSize))
        
        messageView.addSubview(messageTextLabel)
        messageTextLabel.edgesToSuperview(insets: TinyEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        
//        [copyButton].forEach { buttonsStackView.addArrangedSubview($0) }
//        [copyButton].forEach { $0.aspectRatio(1) }
//        buttonsStackView.height(buttonHeight)
        
        [bodyView].forEach { messageStackView.addArrangedSubview($0) }
        bodyView.leadingToSuperview()
        
        [avatarImageViewWrapper, messageStackView].forEach { parentStackView.addArrangedSubview($0) }
        
        [tailImageView, parentStackView].forEach { contentView.addSubview($0) }
        
        messageStackView.width(to: contentView, multiplier: 256 / 375)
        parentStackView.leadingToSuperview(offset: cellConstants.horizontalOffset)
        parentStackView.verticalToSuperview(insets: .vertical(cellConstants.verticalOffset))
                
        tailImageView.bottom(to: bodyView)
        tailImageView.leading(to: bodyView, offset: -5)
    }
    
    private func buttonForPoint(_ point: CGPoint) -> UIButton? {
        guard bounds.contains(point) else { return nil }
        let insets = TinyEdgeInsets.uniform(-buttonsStackView.spacing / 2)
        let buttons = [copyButton]
        for button in buttons {
            if button.isHidden { continue }
            if button.calculateFrameOnScreen(in: contentView).inset(by: insets).contains(point) {
                return button
            }
        }
        return nil
    }
    
    // MARK: - Handlers
    
    @objc private func copyButtonPressed() {
        AppHapticGenerator.impactOccuredLight()
        action.send(.copyMessage)
    }
    
}
