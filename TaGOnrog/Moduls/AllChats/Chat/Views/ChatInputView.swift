import UIKit
import Combine
import TinyConstraints
import Speech
import UITextView_Placeholder

class ChatInputView: UIView {
    
    enum Action {
        case sendPressed(message: String)
    }
    
    private let textView = UITextView()
    private let textScrollView = UIScrollView()
    
    private let micButton = UIButton()
    
    private let textStackView = ViewsFactory.defaultStackView()
    private let textViewWrapper = UIView()
    
    private let sendButton = UIButton()
    private let sendLoadingIndicator = ViewsFactory.defaultActivityIndicator(color: .appWhite)
    
    private let parentStackView = ViewsFactory.defaultStackView(spacing: 8, alignment: .bottom, margins: .uniform(16))
    private let imageCheckMark = AppImage.commonCheckmark.uiImageWith(font: .sFProText(ofSize: 17), tint: .hex3C3C43.withAlphaComponent(0.6))
    
    private var isSendLoading = false
    private var isFileUpload = false
    
    var textIsEmpty: Bool {
        return textView.text.isEmpty
    }
    
    var action: ((Action) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setSendLoading(_ loading: Bool) {
        if isSendLoading == loading {
            return
        }
        isSendLoading = loading
        updateSendButton()
    }
    
    func setText(text: String) {
        textView.text = text
        sendButton.isHidden = text.isEmpty
    }
    
    // MARK: - Helpers
    
    private func commonInit() {
        setTitles()
        setupViews()
        setupLayout()
    }
    
    private func setTitles() {
        textView.placeholder = ^String.Chat.chatEnterYourQuestionTitle
        textView.placeholderColor = .hex3C3C43.withAlphaComponent(0.6)
    }
    
    private func setupViews() {
        backgroundColor = .hexF9F9F9
        
        textView.backgroundColor = .appClear
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = .sFProText(ofSize: 17)
        textView.textContainerInset = .uniform(8)
        
        textScrollView.showsVerticalScrollIndicator = false
        
        textViewWrapper.backgroundColor = .hex767680.withAlphaComponent(0.12)
        textViewWrapper.layer.cornerRadius = 10
        textViewWrapper.clipsToBounds = true
        
        sendButton.backgroundColor = .hexFFDD00
        sendButton.layer.cornerRadius = 10
        sendButton.clipsToBounds = true
        sendButton.isHidden = true
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        updateSendButton()
        
//        micButton.setImage(AppImage.micFill.uiImageWith(tint: .hex3C3C43.withAlphaComponent(0.6)), for: .normal)
//        micButton.addTarget(self, action: #selector(micButtonTouchDown), for: .touchDown)
//        [.touchUpInside, .touchUpOutside].forEach{ micButton.addTarget(self, action: #selector(micButtonTouchUp), for: $0) }
//        micButton.backgroundColor = .appClear
    }
    
    private func setupLayout() {
        textScrollView.addSubview(textView)
        textView.edgesToSuperview()
        textView.widthToSuperview()
        textView.heightToSuperview(priority: .defaultLow + 1)
        textScrollView.height(min: 38, max: 78)
        
        [textScrollView, micButton].forEach(textStackView.addArrangedSubview)
        micButton.width(32)
        micButton.setCompressionResistance(.defaultLow, for: .vertical)
        
        textViewWrapper.addSubview(textStackView)
        textStackView.edgesToSuperview()
        
        sendButton.size(CGSize(width: 34, height: 36))
        
        sendButton.addSubview(sendLoadingIndicator)
        sendLoadingIndicator.centerInSuperview()
        
        [textViewWrapper, sendButton].forEach { parentStackView.addArrangedSubview($0) }
        
        addSubview(parentStackView)
        parentStackView.edgesToSuperview()
    }
    
    private func updateSendButton() {
        textView.isEditable = !isSendLoading
        sendButton.isUserInteractionEnabled = !isSendLoading
        
        let sendImage: UIImage? = {
            if isSendLoading {
                return nil
            }
            return AppImage.paperplaneFill.uiImageWith(font: .sFProTextBold(ofSize: 17), tint: .appWhite)
        }()
        sendButton.setImage(sendImage, for: .normal)
        
        sendLoadingIndicator.isHidden = !isSendLoading
        if isSendLoading {
            sendButton.isHidden = false
            sendLoadingIndicator.startAnimating()
            micButton.isEnabled = false
        } else {
            sendButton.isHidden = textView.text.isEmpty
            sendLoadingIndicator.stopAnimating()
            micButton.isEnabled = true
        }
    }
    
    // MARK: - Handlers
    
    @objc private func sendButtonPressed() {
        AppHapticGenerator.impactOccuredLight()
        let message = (textView.text ?? "").trim()
        if message.isEmpty {
            return
        }
        textView.text.removeAll()
        action?(.sendPressed(message: message))
    }
    
}

extension ChatInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isHidden = textView.text.isEmpty
    }
    
}
