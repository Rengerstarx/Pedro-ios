import Foundation

enum ChatTableCell {
    case sentMessage(message: ChatSentMessageCell)
    case receivedMessage(message: ChatReceivedMessageCell)
}

struct ChatSentMessageCell {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
}

class ChatReceivedMessageCell {
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
}
