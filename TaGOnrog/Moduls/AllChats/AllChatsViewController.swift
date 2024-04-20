//
//  AllChatsViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit
import TinyConstraints

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
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45"),
        ChatModel(name: "huilo", photo: URL(string: "https://sun154-2.userapi.com/s/v1/ig2/f4dpCAblSUazLgBSHX_M0jrnuNTLA2SAFjJ-s3Dve1uM_LqhTVLhPRQfDciKNFjh15DluT5NSSdRmV_TSKnil6Wl.jpg?size=200x0&quality=96&crop=0,0,1328,1328&ava=1")!, lastMessageText: "Я сосал, меня ебали", lastMessageTimeText: "13:45")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitles()
        setupViews()
        setupLayouts()
    }
    
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
