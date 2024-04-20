//
//  DatingModel.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation

struct DatingModel {
    
    let aboutMe: String
    let tags: [String]
    
    init(aboutMe: String, tags: [String]) {
        self.aboutMe = aboutMe
        self.tags = tags
    }
    
}
