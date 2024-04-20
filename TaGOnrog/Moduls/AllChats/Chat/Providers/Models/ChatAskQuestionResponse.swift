//import Foundation
//
//struct ChatAskQuestionResponse: Codable {
//    
//    struct AnswerData: Codable {
//        
//        struct Choice: Codable {
//            
//            struct Message: Codable {
//                let role: String
//                let content: String
//            }
//            
//            let message: Message
//        }
//        
//        let choices: [Choice]
//    }
//    
//    let data: AnswerData
//    
//}
//
//extension ChatAskQuestionResponse {
//    
//    func toReceivedMessage() -> ChatReceivedMessage? {
//        guard let choice = data.choices.first else { return nil }
//        return ChatReceivedMessage(message: NSAttributedString(string: choice.message.content))
//    }
//    
//}
