
import Foundation

// MARK: - Mes
struct Mes: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Resultut?]
}

// MARK: - Result
struct Resultut: Codable {
    let id: Int?
    let name: String?
    let lastMessage: LastMessage?
    let participants: [Author?]

    enum CodingKeys: String, CodingKey {
        case id, name
        case lastMessage = "last_message"
        case participants
    }
}

// MARK: - LastMessage
struct LastMessage: Codable {
    let id: Int?
    let text: String?
    let author: Author?
    let created: String?
}

// MARK: - Author
struct Author: Codable {
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
