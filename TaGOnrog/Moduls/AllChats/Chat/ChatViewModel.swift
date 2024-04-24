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
//        getMessage("окей, я свободна в этот понедельник")
//        getMessage("можно будет погклять в 19-20 часов")
//        appendCell(.sentMessage(message: ChatSentMessageCell(message: "Окау")))
        
    }
    
    func getMessage(_ message: String) {
        let getMessage = ChatReceivedMessageCell(message: message)
        appendCell(.receivedMessage(message: getMessage))
        
    }
    
    
    private func appendGreetingCell() {
        let text = "Привет, давай знакомится!"
        let message = ChatReceivedMessageCell(message: text)
        let cell = ChatTableCell.receivedMessage(message: message)
//        sendMessage("Ну можно будет завтра пересечься")
        appendCell(cell)
    }
    
    private func appendCell(_ cell: ChatTableCell) {
        chatCells.append(cell)
        action.send(.appendCell(chatCell: cell))
    }
    
}
