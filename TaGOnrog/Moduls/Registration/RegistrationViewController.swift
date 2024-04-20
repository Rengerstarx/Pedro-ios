//
//  RegistrationViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation
import UIKit
import TinyConstraints
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class RegistrationViewController: UIViewController {
    
    private let imageViewDemo = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.imageVector.uiImage)
    private let imageViewDemo2 = ViewsFactory.defaultImageView(contentMode: .scaleAspectFit, image: AppImage.imageVector2.uiImage)
    private let mainLabel = ViewsFactory.defaultLabel(lines: 2, textColor: .appBlack, font: .sFProTextBold(ofSize: 30))
    private let mainLabel2 = ViewsFactory.defaultLabel(lines: 2, textColor: .appBlack, font: .sFProTextBold(ofSize: 30), alignment: .right)
    private let continueWithGoogle = ViewsFactory.continueButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainLabel.alpha = 0
        mainLabel2.alpha = 0
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.mainLabel.alpha = 1
            self.mainLabel2.alpha = 1
        }, completion: nil)
    }
    
    private func setupViews() {
        
        view.backgroundColor = .appWhite
        mainLabel.text = "Random\nCoffee - Oggetto"
        mainLabel2.text = "prod by\nClub First"
        
        continueWithGoogle.layer.borderColor = UIColor.appBlack.cgColor
        continueWithGoogle.layer.borderWidth = 2
        continueWithGoogle.backgroundColor = .hexFFDD00.withAlphaComponent(0.9)
        continueWithGoogle.setTitle("Sing In with Google", for: .normal)
        continueWithGoogle.setTitleColor(.appBlack, for: .normal)
        continueWithGoogle.setImage(AppImage.google.uiImageWith(font: .sFProText(ofSize: 16), tint: .appBlack), for: .normal)
        continueWithGoogle.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        continueWithGoogle.addTarget(self, action: #selector(singInGoogle), for: .touchUpInside)
    }
    
    private func setupLayouts() {
        [mainLabel, imageViewDemo, imageViewDemo2, mainLabel2, continueWithGoogle].forEach { view.addSubview($0) }
        mainLabel.centerYToSuperview(offset: -155)
        mainLabel.leftToSuperview(offset: 30)
        
        imageViewDemo.rightToSuperview(usingSafeArea: false)
        imageViewDemo.topToSuperview(usingSafeArea: false)
        imageViewDemo2.leftToSuperview(usingSafeArea: false)
        imageViewDemo2.bottomToSuperview(usingSafeArea: false)
        
        mainLabel2.centerYToSuperview(offset: 165)
        mainLabel2.rightToSuperview(offset: -30)
        
        continueWithGoogle.centerInSuperview()
        continueWithGoogle.leftToSuperview(offset: 20)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    @objc private func singInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let email = result?.user.email {
                    // TODO: send email and validation
                    dismiss(animated: true)
                }
            }
        }
    }
    
}
