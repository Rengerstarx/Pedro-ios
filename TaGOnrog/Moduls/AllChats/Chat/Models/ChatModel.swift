//
//  File.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation

struct ChatModel {
    
    let name: String
    let photo: URL
    let lastMessageText: String
    let lastMessageTimeText: String
    
    init(name: String, photo: URL, lastMessageText: String, lastMessageTimeText: String) {
        self.name = name
        self.photo = photo
        self.lastMessageText = lastMessageText
        self.lastMessageTimeText = lastMessageTimeText
    }
    
}
