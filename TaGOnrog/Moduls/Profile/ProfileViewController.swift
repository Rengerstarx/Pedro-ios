//
//  ProfileViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import Foundation
import UIKit
import TinyConstraints

class ProfileViewController: UIViewController {
    
    private let actionsBarButton = ViewsFactory.defaultBarButton(font: .sFProTextBold(ofSize: 20), image: .calendar, color: .hexFFDD00)
    private let profileView = ProfileView()
    private let model: ProfileModel = ProfileModel(username: "login", email: "test@mailru", firstName: "Коля", lastName: "Трифонов", bd: "29.11.2004", vacation: "ПыхПых разраб", tags: ["Крутой", "Мощный", "Сочный", "Красивый", "Абхазский", "Спелый", "Мандарин"], aboutMe: "Я в своём познании настолько преисполнился, что я как будто бы уже сто триллионов миллиардов лет проживаю на триллионах и триллионах таких же планет, понимаешь, как эта Земля. Мне уже этот мир абсолютно понятен, и я здесь ищу только одного: покоя, умиротворения и вот этой гармонии от слияния с бесконечно вечным.", photo: URL(string: "https://sun9-18.userapi.com/impg/fGzBtxX8QGqcOwmGxSfpeC2HISlbk7OE9tGWTw/BgLHhBH5L0M.jpg?size=1920x1440&quality=95&sign=52cc7109c5b8db59a3f10f1490b19ff7&type=album")!)
    
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
