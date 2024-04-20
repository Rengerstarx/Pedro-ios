//import Foundation
//
//struct ChatAskQuestionRequest: Codable {
//    
//    struct Message: Codable {
//        let role: String
//        let content: String
//    }
//    
//    let messages: [Message]
//    
//}
//
//extension ChatTableCell {
//    
//    var isReceivedMessage: Bool {
//        if case .receivedMessage = self { return true }
//        return false
//    }
//    var message: String? {
//        switch self {
//        case .sentMessage(let message):
//            return message.message
//        case .receivedMessage(let message):
//            switch message {
//            case .message(let message):
//                return message.message.string
//            }
//        }
//    }
//    
//}
//
//extension Array where Element == ChatTableCell {
//    
//    func toRequest(lastMessage: ChatReceivedMessageCell? = nil) -> ChatAskQuestionRequest {
//        let messagesCells: [ChatTableCell] = {
//            var cells = filter { cell in
//                if case .receivedMessage(let message) = cell, case .message = message { return true }
//                if case .sentMessage = cell { return true }
//                return false
//            }
//            if let lastMessage {
//                let index = cells.firstIndex { cell in
//                    if case .receivedMessage(let receivedMessage) = cell, case .message(let message) = receivedMessage {
//                        return lastMessage == message
//                    }
//                    return false
//                }
//                if let index {
//                    cells = Array(cells.prefix(index))
//                }
//            }
//            return cells.suffix(3)
//        }()
//        let messages = messagesCells.compactMap { cell -> ChatAskQuestionRequest.Message? in
//            guard let message = cell.message else { return nil }
//            let role = cell.isReceivedMessage ? "assistant" : "user"
//            return ChatAskQuestionRequest.Message(role: role, content: message)
//        }
//        return ChatAskQuestionRequest(messages: messages)
//    }
//    
//}
