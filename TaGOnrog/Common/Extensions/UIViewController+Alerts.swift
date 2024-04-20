//
//  UIViewController+Alerts.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import TinyConstraints

extension UIViewController {
    
    private func showAlertController(
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        style: UIAlertController.Style = .alert,
        preferredAction: UIAlertAction? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alertController.addAction($0) }
        alertController.preferredAction = preferredAction
        present(alertController, animated: true)
    }
    
    // MARK: - Alerts
    
    func showErrorAlert(message: String?, completion: (() -> Void)? = nil) {
        let okAction = UIAlertAction(title: ^String.Alerts.okTitle, style: .cancel) { _ in completion?() }
        showAlertController(title: ^String.Alerts.errorTitle, message: message, actions: [okAction])
    }
    
    func showInfoAlert(title: String? = ^String.Alerts.infoTitle, message: String? = nil, completion: (() -> Void)? = nil) {
        let okAction = UIAlertAction(title: ^String.Alerts.okTitle, style: .cancel) { _ in completion?() }
        showAlertController(title: title, message: message, actions: [okAction])
    }
    
    func showConfirmationAlert(message: String? = nil, completion: @escaping ((Bool) -> Void)) {
        let yesAction = UIAlertAction(title: ^String.Alerts.yesTitle, style: .default) { _ in completion(true) }
        let noAction = UIAlertAction(title: ^String.Alerts.noTitle, style: .cancel) { _ in completion(false) }
        showAlertController(title: ^String.Alerts.areYouSure, message: message, actions: [yesAction, noAction])
    }
    
    func showDeleteConfirmationAlert(
        title: String? = ^String.Alerts.areYouSure,
        message: String? = "",
        deleteHandler: @escaping () -> Void
    ) {
        let deleteAction = UIAlertAction(title: "", style: .destructive) { _ in
            deleteHandler()
        }
        let cancelAction = UIAlertAction(title: ^String.Common.cancelTitle, style: .cancel)
        showAlertController(title: title, message: message, actions: [deleteAction, cancelAction])
    }
    
    func showAiSubscribeAlert(completion: @escaping () -> Void) {
        let buyAction = UIAlertAction(title: "", style: .default, handler: { _ in
            completion()
        })
        let skipAction = UIAlertAction(title: ^String.Common.cancelTitle, style: .cancel, handler: nil)
        showAlertController(
            title: "",
            message: "",
            actions: [buyAction, skipAction]
        )
    }
    
    func showOpenDocAlert(completion: @escaping (Bool) -> Void) {
        let openAction = UIAlertAction(title: ^String.Alerts.yesTitle, style: .default, handler: { _ in
            completion(true)
        })
        let noAction = UIAlertAction(title: ^String.Alerts.noTitle, style: .default, handler: { _ in
            completion(false)
        })
        showAlertController(
            title: "",
            message: "",
            actions: [noAction, openAction],
            preferredAction: openAction
        )
    }
    
}
