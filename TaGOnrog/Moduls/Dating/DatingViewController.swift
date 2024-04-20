//
//  DatingViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints

class DatingViewController: UIViewController {
    
    private let datingView = DatingView()
    private let backImageView = ViewsFactory.defaultImageView(contentMode: .scaleToFill, image: AppImage.fon.uiImage)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if true {
            let viewController = RegistrationViewController()
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
        setTitles()
        setupViews()
        setupLayouts()
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
