//
//  Factory.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation

public enum ServiceFactory {
    public static func makeNewsService() -> NewsService {
        let base = URL(string: "https://dota2-telegram-bot-production.up.railway.app")!
        let cfg = URLSessionConfiguration.default
        cfg.waitsForConnectivity = true
        cfg.timeoutIntervalForRequest = 20
        cfg.timeoutIntervalForResource = 20
        let session = URLSession(configuration: cfg)
        let client = DefaultAPIClient(baseURL: base, session: session)
        return NewsServiceImpl(api: client)

    }
}
