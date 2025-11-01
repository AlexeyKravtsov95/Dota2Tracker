//
//  NewsService.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation

public protocol NewsService {
    func fetchList(limit: Int) async throws -> [NewsItems]
}

public final class NewsServiceImpl: NewsService {
    private let api: APIClient

    public init(api: APIClient) {
        self.api = api
    }

    public func fetchList(limit: Int) async throws -> [NewsItems] {
        let response: NewListResponse = try await api.get(.newList(limit: limit))
        return response.items
    }
}
