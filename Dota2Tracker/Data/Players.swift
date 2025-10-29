import Foundation

struct Players {
    let name: String
    let avatar: String
    let statusSteam: String
    let wins: String
    let loss: String
    let winrate: String

    static func mockData() -> [Players] {
        [
            .init(name: "Биба", avatar: "ava1", statusSteam: "online", wins: "10", loss: "5", winrate: "55.55%"),
            .init(name: "Боба", avatar: "ava2", statusSteam: "offline", wins: "12", loss: "8", winrate: "57.14%"),
            .init(name: "Пупа", avatar: "ava3", statusSteam: "offline", wins: "15", loss: "10", winrate: "66.67%"),
            .init(name: "Лупа", avatar: "ava4", statusSteam: "offline", wins: "13", loss: "9", winrate: "61.11%"),
        ]
    }
}
