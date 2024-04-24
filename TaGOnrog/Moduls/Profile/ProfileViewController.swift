//
//  ProfileViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import Foundation
import UIKit
import TinyConstraints
import Alamofire

class ProfileViewController: UIViewController {
    
    private let actionsBarButton = ViewsFactory.defaultBarButton(font: .sFProTextBold(ofSize: 20), image: .calendar, color: .hexFFDD00)
    private let profileView = ProfileView()
    private let model: ProfileModel = ProfileModel(username: "login", email: "test@mailru", firstName: "Коля", lastName: "Трифонов", bd: "29.11.2004", vacation: "ПыхПых разраб", tags: [Position(id: 0, name: "Разработка"), Position(id: 0, name: "Зал"), Position(id: 0, name: "Туризм"), Position(id: 0, name: "Игры"), Position(id: 0, name: "Книги"), Position(id: 0, name: "Баскетбол"), Position(id: 0, name: "Фрукты")], aboutMe: "Я в своём познании настолько преисполнился, что я как будто бы уже сто триллионов миллиардов лет проживаю на триллионах и триллионах таких же планет, понимаешь, как эта Земля. Мне уже этот мир абсолютно понятен, и я здесь ищу только одного: покоя, умиротворения и вот этой гармонии от слияния с бесконечно вечным.", photo: URL(string: "https://sun9-18.userapi.com/impg/fGzBtxX8QGqcOwmGxSfpeC2HISlbk7OE9tGWTw/BgLHhBH5L0M.jpg?size=1920x1440&quality=95&sign=52cc7109c5b8db59a3f10f1490b19ff7&type=album")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitles()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        navigationItem.setRightBarButtonItems([actionsBarButton], animated: false)
        actionsBarButton.addTarget(self, action: #selector(actionsBarButtonPressed))
        profileView.setup(model: model)
        profileView.handlerSwipe = { [weak self] in
            guard let mod = self?.model else { return }
            let controller = FullInfoViewControler()
            controller.setup(model: mod)
            self?.present(controller, animated: true)
        }
    }
    
    func setup(i: Int) {
        if let tokenValue = UserDefaults.standard.object(forKey: "token") as? String {
            
            if let url = URL(string: "http://89.208.104.224:8000/api/members/user") {
                let headers: HTTPHeaders = [
                    "x-Authorization": "Bearer \(tokenValue)",
                    "Content-Type": "application/json"
                ]
                
                AF.request(url, method: .get, headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        do {
                            let welcome = try JSONDecoder().decode(Uses.self, from: value as? Data ?? Data())
                            let m = ProfileModel(username: "welcome", email: "", firstName: welcome.firstName, lastName: welcome.lastName, bd: welcome.birthDate, vacation: "", tags: welcome.tags, aboutMe: "welcome", photo: URL(string: welcome.avatar ?? "") ?? URL(string: "https://sun9-18.userapi.com/impg/fGzBtxX8QGqcOwmGxSfpeC2HISlbk7OE9tGWTw/BgLHhBH5L0M.jpg?size=1920x1440&quality=95&sign=52cc7109c5b8db59a3f10f1490b19ff7&type=album")!)
                            self.profileView.setup(model: m)
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
    
    private func setupLayouts() {
        view.addSubview(profileView)
        profileView.edgesToSuperview()
    }
    
    private func setupTitles() {
        navigationItem.title = "Мой профиль"
    }
    
    @objc private func actionsBarButtonPressed() {
        navigationController?.pushViewController(EventsViewController(), animated: true)
    }
    
}
