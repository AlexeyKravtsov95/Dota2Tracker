//
//  APIClient.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation

public protocol APIClient {
    func get<T: Decodable>(
        _ endpoint: Endpoint,
    ) async throws -> T
}

public struct DefaultAPIClient: APIClient {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }

    public func get<T: Decodable>(
        _ endpoint: Endpoint,
    ) async throws -> T {
        var request = try endpoint.urlRequest(baseURL: baseURL)

        do {
            let (data, response) = try await session.data(for: request)
            try validate(response, data: data)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch let urlErr as URLError {
            throw APIError.transport(urlErr)
        } catch let decErr as DecodingError {
            throw APIError.decoding(decErr)
        }
    }

    private func validate(_ response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.http(status: http.statusCode, body: data)
        }
    }
}

