//
//  Images.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 31.01.2024.
//
import UIKit

enum AppImage: String {
    
    //Launchscreen
    case launchscreenAppLogo
    
    //Root
    case heartFill = "heart.fill"
    case personCropCicleFill = "person.crop.circle.fill"
    case commonCheckmark = "checkmark"
    case messageFill = "message.fill"
    case actionsPlus = "plus"
    case presentationsMinus = "minus"
    case google
    
    //Dating
    case likeImage
    case dislikeImage
    case fon
    case likeImageMatch
    case dislikeImageMatch
    
    //Chat
    case aiChatRobotIcon
    case filesDocOnDoc = "doc.on.doc"
    case micFill = "mic.fill"
    case paperplaneFill = "paperplane.fill"
    case aiChatReceivedMessageTail
    case aiChatSentMessageTail
    case calendarBadgePlus = "calendar.badge.plus"
    case calendar = "calendar"
    case figureTwo = "figure.2"
    
    //Profile
    case profileBlur
    case saveImage = "square.and.arrow.down.on.square.fill"
    case demoImageOne
    case demoImageTwo
    case imageVector
    case imageVector2
    
    var uiImage: UIImage? {
        return UIImage(systemName: rawValue) ?? UIImage(named: rawValue)
    }
    
    func uiImageWith(font: UIFont? = nil, tint: UIColor? = nil) -> UIImage? {
        var img = uiImage
        if let font = font {
            img = img?.withConfiguration(UIImage.SymbolConfiguration(font: font))
        }
        if let tint = tint {
            return img?.withTintColor(tint, renderingMode: .alwaysOriginal)
        } else {
            return img
        }
    }
    
}
