//
//  News.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation

public struct NewListResponse: Decodable {
    public let items: [NewsItems]
}

public struct NewsItems: Decodable, Identifiable {
    public var id: String { "\(url)|\(date ?? 0)"}
    public let title: String
    public let url: String
    public let author: String?
    public let date: Int?
    public let feedname: String?
    public let imageUrl: String?

    public var linkURL: URL? { URL(string: url) }
    public var previewURL: URL? { imageUrl.flatMap(URL.init(string:)) }
    public var dateFormatted: String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
    }
}
