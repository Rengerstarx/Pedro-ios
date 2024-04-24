//
//  ProfileModel.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation

struct ProfileModel {
    
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let bd: String
    let vacation: String
    let tags: [Position?]
    let aboutMe: String
    let photo: URL
    
    init(username: String?, email: String?, firstName: String?, lastName: String?, bd: String?, vacation: String?, tags: [Position?], aboutMe: String?, photo: URL) {
        self.username = username ?? ""
        self.email = email ?? ""
        self.firstName = firstName ?? ""
        self.lastName = lastName ?? ""
        self.bd = bd ?? ""
        self.vacation = vacation ?? ""
        self.tags = tags ?? []
        self.aboutMe = aboutMe ?? ""
        self.photo = photo
    }
    
    func getData(key: String) -> String {
        switch key{
        case "Имя Фамилия":
            return "\(firstName) \(lastName)"
        case "Почта":
            return email
        case "День рождения":
            return bd
        case "Должность":
            return vacation
        case "Обо мне":
            return aboutMe
        default:
            return ""
        }
    }
    
}
