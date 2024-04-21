//
//  Mes.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 21.04.2024.
//

import Foundation

// MARK: - Mes
struct Mes: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Result?]
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name: String?
    let lastMessage: LastMessage?

    enum CodingKeys: String, CodingKey {
        case id, name
        case lastMessage = "last_message"
    }
}

// MARK: - LastMessage
struct LastMessage: Codable {
    let id: Int?
    let text: String?
    let author: Author?
}

// MARK: - Author
struct Author: Codable {
    let id: Int?
    let username, email, firstName, lastName: String?
    let avatar, birthDate: String?
    let ages: Int?
    let timePreference: String?
    let groups, tags: [Position]
    let position: Position?

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case birthDate = "birth_date"
        case ages
        case timePreference = "time_preference"
        case groups, tags, position
    }
}

