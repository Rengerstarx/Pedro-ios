import TinyConstraints
import UIViewController_KeyboardAnimation
import Combine
import AMPopTip
import PDFKit

class ChatViewController: UIViewController {
    
    private let tableView = ChatTableView()
    private let chatInputView = ChatInputView()
    private let parentStackView = ViewsFactory.defaultStackView(axis: .vertical)
    private var parentStackViewBottom: Constraint?
    private let actionsBarButton = ViewsFactory.defaultBarButton(font: .sFProTextBold(ofSize: 20), image: .calendarBadgePlus, color: .hexFFDD00)
    
    private let viewModel = ChatViewModel()
    
    private var observables: [AnyCancellable] = []
    
    private var keyboardHeight: CGFloat = 0
    
    private var bottomOffset: CGFloat {
        return keyboardHeight
    }
    private let popTip = PopTip()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleStateUpdate(state)
            }
            .store(in: &observables)
        viewModel.action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.handleAction(action)
            }
            .store(in: &observables)
        viewModel.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        an_subscribeKeyboardShowHide { [weak self] frame, _, show in
            self?.handleKeyboardShowHide(frame: frame, show: show)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        an_unsubscribeKeyboardShowHide()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Helpers
    
    func setTitles(model: ChatModel) {
        navigationItem.title = model.name
        tableView.photoUserUrl = model.photo
    }
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setRightBarButtonItems([actionsBarButton], animated: false)
        actionsBarButton.addTarget(self, action: #selector(actionsBarButtonPressed))
        view.backgroundColor = .appWhite
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(viewTap)
        
        tableView.action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.handleTableAction(action)
            }
            .store(in: &observables)
        chatInputView.action = { [weak self] action in
            switch action {
            case .sendPressed(let message):
                self?.viewModel.sendMessage(message)
            }
        }
        
        popTip.bubbleColor = .appClear
        popTip.cornerRadius = 16
        popTip.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 150))
        popTip.padding = 0.0
        popTip.shouldDismissOnTap = false
        popTip.shouldDismissOnTapOutside = true
        popTip.shouldDismissOnSwipeOutside = true
    }
    
    private func setupLayout() {
        [tableView, chatInputView].forEach { parentStackView.addArrangedSubview($0) }
        
        view.addSubview(parentStackView)
        parentStackView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        parentStackViewBottom = parentStackView.bottomToSuperview(usingSafeArea: true)
        updateParentStackViewBottom()
    }
    
    private func updateParentStackViewBottom() {
        parentStackViewBottom?.constant = -bottomOffset
        view.layoutIfNeeded()
    }
    
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Handlers
    
    @objc private func viewTapped() {
        hideKeyboard()
    }
    
    private func handleStateUpdate(_ state: ChatViewModel.State) {
        navigationItem.setLeftBarButtonItems([], animated: true)
        chatInputView.setSendLoading(state.sendLoading)
    }
    
    private func handleAction(_ action: ChatViewModel.Action) {
        switch action {
        case .appendCell(let chatCell):
            tableView.appendCell(chatCell)
        case .error(let error):
            showErrorAlert(message: error)
        }
    }
    
    private func handleTableAction(_ action: ChatTableView.Action) {
        switch action {
        case .copyMessage(let message):
            UIPasteboard.general.string = message.message
        }
    }
    
    private func handleKeyboardShowHide(frame: CGRect, show: Bool) {
        var heightDifference = bottomOffset
        keyboardHeight = show ? frame.height - view.safeAreaInsets.bottom : 0
        heightDifference -= bottomOffset
        if heightDifference != 0 {
            var contentOffset = tableView.contentOffset
            contentOffset.y -= heightDifference
            tableView.setContentOffset(contentOffset, animated: false)
        }
        updateParentStackViewBottom()
    }
    
    func hideSettings() {
        popTip.hide()
    }
    
    @objc private func actionsBarButtonPressed() {
        if popTip.isVisible {
            hideSettings()
            return
        }
//        actionsBarButton.customView = UIView()
        let popPoint = CGRect(origin: CGPoint(x: Constants.screenWidth - 70, y: 100), size: .zero)
//        popPoint?.origin.y += 10
        popTip.show(customView: ChatEventView(), direction: .down, in: view, from: popPoint)
    }
    
}
