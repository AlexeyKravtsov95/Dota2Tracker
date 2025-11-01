//
//  NewsListModel.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation
import Dota2APIKit
internal import Combine

@MainActor
final class NewsListModel: ObservableObject {
    @Published var items: [NewsItems] = []
    @Published var isLoading = false
    @Published var errorText: String?

    private let service: NewsService

    init(service: NewsService) {
        self.service = service
    }

    func load(limit: Int = 5) async {
        isLoading = true
        errorText = nil
        do {
            let data = try await service.fetchList(limit: limit)
            self.items = data
            self.isLoading = false
        } catch let api as APIError {
            self.isLoading = false
            self.errorText = api.localizedDescription
        } catch {
            self.isLoading = false
            self.errorText = error.localizedDescription
        }
    }
}
