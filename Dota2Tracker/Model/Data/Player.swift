import Foundation

// MARK: - Data from WelcomeScreen
struct Welcome: Decodable {
    let status: String
    let players: [Player]
    let page, limit, total: Int
}

// MARK: - Player
struct Player: Decodable {
    let accountID: Int
    let personaName: String
    let avatarFull: String
    let lastMatchTime: String?
    let similarity: Double
    let isOnline: Bool

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case personaName = "personaname"
        case avatarFull = "avatarfull"
        case lastMatchTime = "last_match_time"
        case similarity = "similarity"
        case isOnline = "is_online"
    }
}
