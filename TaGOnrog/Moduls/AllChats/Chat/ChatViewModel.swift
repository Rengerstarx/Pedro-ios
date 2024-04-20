import Foundation
import Combine
import UIKit

class ChatViewModel {
    
    struct State {
        var sendLoading = false
    }
    
    enum Action {
        case appendCell(chatCell: ChatTableCell)
        case error(error: String)
    }
    
//    private let chatProvider = ChatProvider()
    
    @Published private(set) var state = State()
    
    let action = PassthroughSubject<Action, Never>()
        
    private var chatCells: [ChatTableCell] = []
    
    func viewLoaded() {
        appendGreetingCell()
    }
    
    func sendMessage(_ message: String) {
        let sentMessage = ChatSentMessageCell(message: message)
        appendCell(.sentMessage(message: sentMessage))
        
//        let request = chatCells.toRequest()
        
//        sendMessage(request: request) { [weak self] receivedMessage in
//            self?.action.send(.appendCell(chatCell: .receivedMessage(message: .message(message: receivedMessage))))
//        }
    }
    
    func getMessage(_ message: String) {
        let getMessage = ChatReceivedMessageCell(message: message)
        appendCell(.receivedMessage(message: getMessage))
        
//        let request = chatCells.toRequest()
    }
    
    // MARK: - Helpers
    
//    private func sendMessage(request: ChatAskQuestionRequest, successHandler: @escaping (ChatReceivedMessage) -> Void) {
//        state.sendLoading = true
//        let completion: () -> Void = { [weak self] in self?.state.sendLoading = false }
//        
//        
//        
//        chatProvider.askQuestion(request: request) { [weak self] result in
//            switch result {
//            case .success(let receivedMessage):
//                completion()
//                successHandler(receivedMessage)
//            case .failure(let error):
//                completion()
//                self?.action.send(.error(error: error.localizedDescription))
//            }
//        }
//        
//    }
    
    private func appendGreetingCell() {
        let text = "bebra"
        let message = ChatReceivedMessageCell(message: text)
        let cell = ChatTableCell.receivedMessage(message: message)
        appendCell(cell)
    }
    
    private func appendCell(_ cell: ChatTableCell) {
        chatCells.append(cell)
        action.send(.appendCell(chatCell: cell))
    }
    
}
