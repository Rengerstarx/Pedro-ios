//
//  EventsCategory.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation

struct EventsCategoryItem {
    
    let title: String
    let description: String
    let icon: String
    private let images = ["🚀","✍️","🕒","🛄","🧹","🤝","🌱","📚","📅","💵","🌴","🏡","🍲"]
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        let randomIndex = Int.random(in: 0..<images.count)
        self.icon = images[randomIndex]
    }
    
}
