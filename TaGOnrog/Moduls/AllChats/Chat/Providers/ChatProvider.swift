//import Moya
//import Alamofire
//
//enum ChatRequest {
//    case askQuestion(request: ChatAskQuestionRequest)
//}
//
//extension ChatRequest: TargetType {
//    
//    var baseURL: URL {
//        return URL(string: "https://smmvalidationandroid.online")!
//    }
//    
//    var path: String {
//        switch self {
//        case .askQuestion:
//            return "/api/documents7/chatbot/question"
//        }
//    }
//    
//    var method: Moya.Method {
//        return .post
//    }
//    
//    var task: Moya.Task {
//        switch self {
//        case .askQuestion(let request):
//            return .requestJSONEncodable(request)
//        }
//    }
//    
//    var headers: [String : String]? {
//        switch self {
//        case .askQuestion(_):
//            return [
//                "Content-type": "application/json"
//            ]
//        }
//    }
//    
//}
//
//class ChatProvider {
//    
//    private let provider = MoyaProvider<ChatRequest>()
//    
//    func askQuestion(
//        request: ChatAskQuestionRequest,
//        completion: @escaping (Result<ChatReceivedMessage, Error>) -> Void
//    ) {
//        provider.request(
//            .askQuestion(
//                request: request
//            )
//        ) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let response = try response.map(ChatAskQuestionResponse.self)
//                    guard let message = response.toReceivedMessage() else {
//                        completion(.failure(^String.Chat.chatSomethingWentWrongTitle as! Error))
//                        return
//                    }
//                    completion(.success(message))
//                } catch {
//                    completion(.failure(^String.Chat.chatSomethingWentWrongTitle as! Error))
//                }
//            case .failure(let error):
//                if error.isCancelled() {
//                    return
//                }
//                completion(.failure(^String.Chat.chatSomethingWentWrongTitle as! Error))
//            }
//        }
//    }
//    
//}
