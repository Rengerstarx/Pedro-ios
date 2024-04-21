//
//  File.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import Foundation

struct ChatModel: Codable {
    
    let name: String
    let photo: URL
    let lastMessageText: String
    let lastMessageTimeText: String
    
    init(name: String?, photo: URL?, lastMessageText: String?, lastMessageTimeText: String?) {
        self.name = name ?? ""
        self.photo = photo ?? URL(string: "https://sun156-1.userapi.com/s/v1/if2/mb45q_TYlJimmjaZfV83pK2Nv0AwGXI8eEDQEFJ_wc-_k0pqO-QN0yopxHK5GfjPJf3S7g-Hta619Uj5sqokmxTg.jpg?quality=95&crop=178,251,1742,1742&as=50x50,100x100,200x200,400x400&ava=1&u=iHbCLB-fylm1TmjETCPYrfBzK3QU0Lqj3NkdCkGmajg&cs=400x400")!
        self.lastMessageText = lastMessageText ?? ""
        self.lastMessageTimeText = lastMessageTimeText ?? ""
    }
    
}
