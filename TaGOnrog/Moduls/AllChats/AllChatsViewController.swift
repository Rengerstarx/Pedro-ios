//
//  AllChatsViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import TinyConstraints
import Alamofire

class AllChatsViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .appClear
        return collectionView
    }()
    private let cellIdentifier = String(describing: AllChatCollectionViewCell.self)
    private let chatsList: [ChatModel] = [
        ChatModel(name: "Настя", photo: URL(string: "https://sun155-2.userapi.com/s/v1/if2/eLPVx05j8STCRZgpOZXbHuFxldZP2F1fLqDFgQb9GpRsWDYHDZNHX5Hmc9bCkE04EVGAcZSFs3lqjitQq0J2NqQF.jpg?quality=95&crop=216,177,2257,2257&as=50x50,100x100,200x200,400x400&ava=1&u=Xbeb3Ptjifk8BZ6cL3iOIFPbuxqMnsNouOAPCMuz6ZE&cs=400x400")!, lastMessageText: "До завтра", lastMessageTimeText: "23:45"),
        ChatModel(name: "Александр", photo: URL(string: "https://sun156-2.userapi.com/s/v1/if2/ENldKlFrgeF4LMIWb_ZnkGoF8x5_eeL1XNF61VBSISnUqESpz5X0Ib4KykS7nIHLHQIW9hFqaMme2fpa96cdFR5I.jpg?quality=95&crop=869,28,1358,1358&as=50x50,100x100,200x200,400x400&ava=1&u=21ldmwftnfjfAuIZ9sIt3TLPpFpS8P4bb-tk_pIcyvE&cs=400x400")!, lastMessageText: "Нуууу, ладно", lastMessageTimeText: "10:21"),
        ChatModel(name: "Лиза", photo: URL(string: "https://sun154-2.userapi.com/s/v1/if2/HTdXcrxDTDVxrcpWwKvM9YvAk6WEVvPEFHAY0xvwny5pZnMjr56I9ZW1sZTNRVn7hQ_VWxy3hm6wj-jcSPm7LUWJ.jpg?quality=95&crop=425,462,469,469&as=50x50,100x100,200x200,400x400&ava=1&u=R1yBpmK4z3tIaSIWdKaYkYKV4WiOvihNjKPWC4MkNJw&cs=400x400")!, lastMessageText: "Окей", lastMessageTimeText: "15:16"),
        ChatModel(name: "Давид", photo: URL(string: "https://sun156-1.userapi.com/s/v1/if2/4PE5H94jMusJMR9zjAQWi5FAeTIPSJGQndh8nv2I79NpMDdbxevkFzyisSijxowQc7dHWtDzxyfBZNrgI3-2xTTg.jpg?quality=95&crop=262,113,424,424&as=50x50,100x100,200x200,400x400&ava=1&u=tidvlapbX-0kocUGXqXtDEmt9xqbxtBS3L4aPBRafqw&cs=400x400")!, lastMessageText: "Договорились!", lastMessageTimeText: "22:47"),
        ChatModel(name: "Альбина", photo: URL(string: "https://sun154-1.userapi.com/s/v1/if2/OH8aRduNa45OX2GqoFYzfsgr9VT08WzGS_48MhT6ijqLf5UE28lI5C7tnYzECZgYDxAicoz38Z2CbcgLFUa7WYGq.jpg?quality=95&crop=0,55,1284,1284&as=50x50,100x100,200x200,400x400&ava=1&u=e0DrW0OoUAHWTBLDSu3M2ikTLoXx_FsXiaP7dtYKfQM&cs=400x400")!, lastMessageText: "Ладно", lastMessageTimeText: "11:19"),
        ChatModel(name: "Киррилл", photo: URL(string: "https://sun156-1.userapi.com/s/v1/if2/mb45q_TYlJimmjaZfV83pK2Nv0AwGXI8eEDQEFJ_wc-_k0pqO-QN0yopxHK5GfjPJf3S7g-Hta619Uj5sqokmxTg.jpg?quality=95&crop=178,251,1742,1742&as=50x50,100x100,200x200,400x400&ava=1&u=iHbCLB-fylm1TmjETCPYrfBzK3QU0Lqj3NkdCkGmajg&cs=400x400")!, lastMessageText: "В 10 в Баре", lastMessageTimeText: "20:55")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitles()
        setupViews()
        setupLayouts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.data(forKey: "bump") {
            if let chatModel = try? PropertyListDecoder().decode(ChatModel.self, from: data) {
                print(chatModel)

            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let tokenValue = UserDefaults.standard.object(forKey: "token") as? String {
//            
//            if let url = URL(string: "http://89.208.104.224:8000/api/chats/chat") {
//                let headers: HTTPHeaders = [
//                    "x-Authorization": "Bearer \(tokenValue)",
//                    "Content-Type": "application/json"
//                ]
//                
//                AF.request(url, method: .get, headers: headers).responseJSON { response in
//                    switch response.result {
//                    case .success(let value):
//                        do {
//                            let welcome = try JSONDecoder().decode(Mes.self, from: value as? Data ?? Data())
//                            welcome.results.forEach { res in
//                                chatsList.append(ChatModel(name: res?.name, photo: res?.lastMessage?.author?.avatar, lastMessageText: res?.lastMessage?.text, lastMessageTimeText: ""))
//                            }
//                            self.collectionView.reloadData()
//                            
//                        } catch {
//                            print("Error decoding JSON: \(error)")
//                        }
//                    case .failure(let error):
//                        print("Something went wrong: \(error.localizedDescription)")
//                    }
//                }
//            }
//        }
//    }
    
    private func setTitles() {
        navigationItem.title = ^String.Chat.chatTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupViews() {
        view.backgroundColor = .appWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AllChatCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupLayouts() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
}

extension AllChatsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let messageCell = cell as? AllChatCollectionViewCell
        messageCell?.setup(model: chatsList[indexPath.item])
        messageCell?.handler = { [weak self] in
            let vc = ProfileViewController()
            vc.setup(i: 0)
            self?.present(vc, animated: true)
        }
        return cell
    }
    
}

extension AllChatsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.screenWidth, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension AllChatsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ChatViewController()
        controller.setTitles(model: chatsList[indexPath.item])
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
