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

    struct PlayerStat: Codable {
        let status: String
        let profile: PlayerStatProfile
    }
}
// MARK: - PlayerStatProfile
struct PlayerStatProfile: Codable {
    let profile: Profile
    let rankTier: Int
    let leaderboardRank: String?
    let computedRating: String?

    enum CodingKeys: String, CodingKey {
        case profile
        case rankTier = "rank_tier"
        case leaderboardRank = "leaderboard_rank"
        case computedRating = "computed_rating"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let accountID: Int
    let personaname: String
    let name: String?
    let plus: Bool
    let cheese: Int
    let steamid: String
    let avatar: String
    let avatarmedium: String
    let avatarfull: String
    let profileurl: String
    let lastLogin: String?
    let loccountrycode: String?
    let status: String?
    let fhUnavailable, isContributor, isSubscriber, isOnline: Bool
    let rankIcon: String
    let wins, losses: Int
    let winrate: Double

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case personaname, name, plus, cheese, steamid, avatar, avatarmedium, avatarfull, profileurl
        case lastLogin = "last_login"
        case loccountrycode, status
        case fhUnavailable = "fh_unavailable"
        case isContributor = "is_contributor"
        case isSubscriber = "is_subscriber"
        case isOnline = "is_online"
        case rankIcon = "rank_icon"
        case wins, losses, winrate
    }
}
