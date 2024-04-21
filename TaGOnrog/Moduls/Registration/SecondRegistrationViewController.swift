//
//  SecondRegistrationViewController.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation
import UIKit
import TinyConstraints

class SecondRegistrationViewController: UIViewController {
    
    private let parentStackView = ViewsFactory.defaultStackView(axis: .vertical, spacing: 8)
    private let continueButton = ViewsFactory.continueButton()
    private let uploadPhotoButton = ViewsFactory.continueButton()
    
    private var isLoadeedPhoto: URL? = nil

    private let headers = [
        "Имя Фамилия",
        "Почта",
        "День рождения",
        "Должность",
        "Обо мне",
        "Тэги"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = .appWhite
        uploadPhotoButton.backgroundColor = .hexFFDD00
        uploadPhotoButton.setTitle("Загрузить фото", for: .normal)
        uploadPhotoButton.setTitleColor(.appBlack, for: .normal)
        uploadPhotoButton.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        
        continueButton.backgroundColor = .hexFFDD00
        continueButton.titleLabel?.textColor = .appBlack
        continueButton.setTitle("Авторизоватсья", for: .normal)
        continueButton.setTitleColor(.appBlack, for: .normal)
        continueButton.addTarget(self, action: #selector(singInPressed), for: .touchUpInside)
        setup()
    }
    
    private func setupLayouts() {
        view.addSubview(parentStackView)
        view.addSubview(uploadPhotoButton)
        view.addSubview(continueButton)
        parentStackView.edgesToSuperview(excluding: .bottom, insets: .uniform(8), usingSafeArea: true)
        continueButton.edgesToSuperview(excluding: .top, insets: .bottom(20) + .horizontal(20))
        uploadPhotoButton.topToBottom(of: parentStackView, offset: 8)
        uploadPhotoButton.horizontalToSuperview(insets: .horizontal(20))
    }
    
    private func setup() {
        headers.forEach { header in
            let stack = ViewsFactory.defaultStackView(axis: .vertical, spacing: 5)
            let titleLabel = ViewsFactory.defaultLabel(textColor: .appSystemGray, font: .sFProText(ofSize: 13))
            titleLabel.text = header
            let textView = getTextView()
            if header != "Обо мне" || header != "Тэги" { textView.height(45) }
            else { textView.height(200) }
            [titleLabel, textView].forEach {stack.addArrangedSubview($0)}
            parentStackView.addArrangedSubview(stack)
        }
    }
    
    private func getTextView() -> UITextView {
        let view = UITextView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexFFDD00.cgColor
        view.font = .sFProTextSemibold(ofSize: 18)
        view.backgroundColor = .appWhite
        view.textColor = .appBlack
        view.contentInset = .uniform(2)
        view.textAlignment = .left
        view.contentOffset.y = (view.contentSize.height - view.frame.height) / 2
        return view
    }
    
    @objc private func singInPressed() {
        var marker = false
        var string: [String] = []
        view.subviews.forEach { sub in
            if let textView = sub as? UITextView {
                marker = textView.text.isEmpty
                string.append(textView.text)
            }
        }
        if marker || isLoadeedPhoto == nil { return }
        // TODO: load to server
        print("load")
        self.dismiss(animated: false)
    }
    
    @objc private func uploadPhoto() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.image"], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }

    
}

extension SecondRegistrationViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        isLoadeedPhoto = selectedFileURL
        // Process the selected file
        // Example: Access the selected file using selectedFileURL
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // Handle cancellation
    }
}
