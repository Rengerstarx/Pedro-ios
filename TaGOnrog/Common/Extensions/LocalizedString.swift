//
//  LocalizedString.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 31.01.2024.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    enum Root: String {
        case datingTitle
        case chatTitle
        case profileTitle
    }
    
    enum Common: String {
        case termsOfUsage
        case privacyPolicy
        case cancelTitle
    }
    
    enum Chat: String {
        case chatTitle
        case chatSomethingWentWrongTitle
        case chatNoMicPermissionAlertText
        case chatVoiceSearchEnablePermissionsAlertText
        case chatVoiceRecognizerNotAvailableForLanguage
        case chatEnterYourQuestionTitle
        case timeIntervalString
    }
    
    enum Alerts: String {
        case errorTitle
        case okTitle
        case infoTitle
        case yesTitle
        case noTitle
        case areYouSure
        case doYouLikeOurAppTitle
        case helpUsGetBetterByAnsweringTitle
    }
    
}

extension RawRepresentable {
    
    func format(_ args: CVarArg...) -> String {
        let format = ^self
        return String(format: format, arguments: args)
    }
    
}

prefix operator ^
prefix func ^<Type: RawRepresentable> (_ value: Type) -> String {
    if let raw = value.rawValue as? String {
        let key = raw.capitalizeFirstLetter()
        return NSLocalizedString(key, comment: "")
    }
    return ""
}

