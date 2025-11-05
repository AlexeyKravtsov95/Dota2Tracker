//
//  Endpoing.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation

public struct Endpoint {
    public let path: String
    public let query: [URLQueryItem]

    public init(path: String, query: [URLQueryItem] = []) {
        self.path = path
        self.query = query
    }

    public func urlRequest(baseURL: URL) throws -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true) else {
            throw APIError.invalidURL
        }

        components.queryItems = query.isEmpty ? nil : query
        guard let url = components.url else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

public extension Endpoint {
    static func newList(limit: Int) -> Endpoint {
        Endpoint(path: "/news/list",
                 query: [URLQueryItem(name: "limit", value: String(limit))])
    }
}
