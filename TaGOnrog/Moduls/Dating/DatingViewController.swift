//
//  DatingViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints
import Alamofire

class DatingViewController: UIViewController {
    
    private let datingView = DatingView()
    private let backImageView = ViewsFactory.defaultImageView(contentMode: .scaleToFill, image: AppImage.fon.uiImage)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ap()
//        datingView.hand = { result in
//            self.ap()
//        }
//        let viewController = BumpViewControler()
//        viewController.handler = {
//            viewController.dismiss(animated: false)
//            let m = ChatModel(name: "Даня", photo: URL(string: "https://sun156-2.userapi.com/s/v1/if2/ENldKlFrgeF4LMIWb_ZnkGoF8x5_eeL1XNF61VBSISnUqESpz5X0Ib4KykS7nIHLHQIW9hFqaMme2fpa96cdFR5I.jpg?quality=95&crop=869,28,1358,1358&as=50x50,100x100,200x200,400x400&ava=1&u=21ldmwftnfjfAuIZ9sIt3TLPpFpS8P4bb-tk_pIcyvE&cs=400x400")!, lastMessageText: "", lastMessageTimeText: "")
//
//            Manager.shared.open(m: m)
//            UserDefaults.standard.set(try? PropertyListEncoder().encode(m), forKey: "bump")
//        }
//        viewController.modalPresentationStyle = .fullScreen
//        viewController.setup([AppImage.skuf1.uiImage, AppImage.skuf2.uiImage])
//        present(viewController, animated: false, completion: nil)
//        if let savedValue = UserDefaults.standard.object(forKey: "regComplite") as? Bool {
//            if let tokenValue = UserDefaults.standard.object(forKey: "token") as? String {
//                if let url = URL(string: "http://89.208.104.224:8000/api/recommendations/match") {
//                    let headers: HTTPHeaders = [
//                        "x-Authorization": "Bearer \(tokenValue)",
//                        "Content-Type": "application/json"
//                    ]
//                    
//                    AF.request(url, method: .get, headers: headers).responseJSON { response in
//                        switch response.result {
//                        case .success(let value):
//                            do {
//                                let welcome = try JSONDecoder().decode(Match.self, from: value as? Data ?? Data())
//                                
//                            } catch {
//                                print("Error decoding JSON: \(error)")
//                            }
//                        case .failure(let error):
//                            print("Something went wrong: \(error.localizedDescription)")
//                        }
//                    }
//                }
//            }
//        } else {
//            let viewController = RegistrationViewController()
//            viewController.modalPresentationStyle = .fullScreen
////            viewController.setup([AppImage.skuf1.uiImage, AppImage.skuf2.uiImage])
//            present(viewController, animated: true, completion: nil)
//        }
        setTitles()
        setupViews()
        setupLayouts()
    }
    
    func ap() {
        if let tokenValue = UserDefaults.standard.object(forKey: "token") as? String {
            if let url = URL(string: "http://89.208.104.224:8000/api/recommendations/match/21/") {
                let headers: HTTPHeaders = [
                    "x-Authorization": "Bearer \(tokenValue)",
                    "Content-Type": "application/json"
                ]
                let parameters: [String: Any] = [
                            "state": 1
                        ]
                
                AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        do {
                            let welcome = try JSONDecoder().decode(Mmmm.self, from: value as? Data ?? Data())
                            let t = 1
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    case .failure(let error):
                        print("Something went wrong: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func setupViews() {
        datingView.setup()
        view.backgroundColor = .appWhite
    }
    
    private func setTitles() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = ^String.Root.datingTitle
    }
    
    private func setupLayouts() {
        view.addSubview(backImageView)
        view.addSubview(datingView)
        datingView.edgesToSuperview(usingSafeArea: true)
        backImageView.edgesToSuperview()
    }
    
}

class Manager {
    static let shared = Manager()
    var hand: ((ChatModel) -> Void)?
    
    func open(m: ChatModel) {
        hand?(m)
    }
}
