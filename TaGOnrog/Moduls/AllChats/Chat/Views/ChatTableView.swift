import UIKit
import Combine

class ChatTableView: UITableView {
    
    enum Action {
        case copyMessage(message: ChatReceivedMessageCell)
    }
    
    private let sentMessageCellIdentifier = String(describing: ChatSentMessageTableViewCell.self)
    private let receivedMessageCellIdentifier = String(describing: ChatReceivedMessageTableViewCell.self)
    
    private var tableCells: [ChatTableCell] = []
    var photoUserUrl: URL? = nil
    
    let action = PassthroughSubject<Action, Never>()
    
    init() {
        super.init(frame: .zero, style: .plain)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appendCell(_ cell: ChatTableCell) {
        let index = tableCells.count
        tableCells.insert(cell, at: index)
        let indexPath = IndexPath(row: index, section: 0)
        insertRows(at: [indexPath], with: .none)
        //main queue fixes scroll animation bug
        DispatchQueue.main.async { [weak self] in
            self?.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToEnd() {
        let lastRowIndex = numberOfRows(inSection: 0) - 1
        let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
        scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        showsVerticalScrollIndicator = false
        
        contentInset = .vertical(12)
        
        separatorStyle = .none
        
        register(ChatSentMessageTableViewCell.self, forCellReuseIdentifier: sentMessageCellIdentifier)
        register(ChatReceivedMessageTableViewCell.self, forCellReuseIdentifier: receivedMessageCellIdentifier)
        
        dataSource = self
        delegate = self
    }
    
    private func handleReceivedMessageCellAction(_ cellAction: ChatReceivedMessageTableViewCell.Action, cell: ChatReceivedMessageCell) {
        switch cellAction {
        case .copyMessage:
            action.send(.copyMessage(message: cell))
        }
    }
    
}

// MARK: - UITableViewDataSource

extension ChatTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableCells[indexPath.row]
        switch tableCell {
        case .sentMessage(let messageCell):
            let cell = tableView.dequeueReusableCell(withIdentifier: sentMessageCellIdentifier, for: indexPath)
            let sendMessage = cell as? ChatSentMessageTableViewCell
            sendMessage?.update(cell: messageCell)
            return cell
        case .receivedMessage(let messageCell):
            let cell = tableView.dequeueReusableCell(withIdentifier: receivedMessageCellIdentifier, for: indexPath)
            let receivedMessageCell = cell as? ChatReceivedMessageTableViewCell
            receivedMessageCell?.update(cell: messageCell, photo: photoUserUrl)
            receivedMessageCell?.observable = receivedMessageCell?.action
                .sink { [weak self] action in
                    self?.handleReceivedMessageCellAction(action, cell: messageCell)
                }
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension ChatTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

