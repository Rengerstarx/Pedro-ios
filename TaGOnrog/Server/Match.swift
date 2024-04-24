//
//  Match.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 21.04.2024.
//

import Foundation

// MARK: - Match
struct Match: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Results?]
}

// MARK: - Result
struct Results: Codable {
    let id: Int?
    let object: ObjectS?
    let state: Int?
    let isBump: String?

    enum CodingKeys: String, CodingKey {
        case id, object, state
        case isBump = "is_bump"
    }
}

// MARK: - Object
struct ObjectS: Codable {
    let id: Int?
    let tags: [Position?]
    let about: String?
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int?
    let name: String?
}

