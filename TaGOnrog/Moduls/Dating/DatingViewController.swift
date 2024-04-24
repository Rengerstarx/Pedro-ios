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
    let vc = BumpViewControler()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE0MjkwMDczLCJpYXQiOjE3MTM2ODUyNzMsImp0aSI6ImZjODUyMzc0MjQ0MTRiNWVhM2Y2N2FkYzk1MDdmNTQyIiwidXNlcl9pZCI6Mn0.s6wu1ib6QCLWxo7y3irA4EEoNFDtrZqbpth6Hwh778U", forKey: "token")
        UserDefaults.standard.set(5, forKey: "mes")
        
        datingView.hand = { result in
            self.ap()
        }
        setTitles()
        setupViews()
        setupLayouts()
        

    }
    
    func ap() {
        if let tokenValue = UserDefaults.standard.object(forKey: "token") as? String {
            if let url = URL(string: "http://89.208.104.224:8000/api/recommendations/match/22/") {
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
