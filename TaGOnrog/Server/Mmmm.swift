//
//  Mmmm.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 21.04.2024.
//

import Foundation

// MARK: - Mmmm
struct Mmmm: Codable {
    let id: Int?
    let object: ObjectZ?
    let objectBumpInfo: ObjectBumpInfo?
    let state: Int?
    let isBump: String?

    enum CodingKeys: String, CodingKey {
        case id, object
        case objectBumpInfo = "object_bump_info"
        case state
        case isBump = "is_bump"
    }
}

// MARK: - Object
struct ObjectZ: Codable {
    let id: Int?
    let tags: [Position?]
    let about: String?
}

// MARK: - ObjectBumpInfo
struct ObjectBumpInfo: Codable {
    let id: Int?
    let username, email, firstName, lastName: String?
    let avatar, birthDate: String?
    let ages: Int?
    let timePreference, about: String?
    let groups, tags: [Position?]
    let position: Position?

    enum CodingKeys: String, CodingKey {
        case id, username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case birthDate = "birth_date"
        case ages
        case timePreference = "time_preference"
        case about, groups, tags, position
    }
}
