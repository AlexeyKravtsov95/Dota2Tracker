//
//  APIError.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import Foundation

public enum APIError: Error {
    case transport(URLError)
    case http(status: Int, body: Data?)
    case decoding(Error)
    case invalidURL

    public var errorDescription: String? {
        switch self {
        case .transport(let error):
            return error.localizedDescription
        case .http(status: let status, body: _):
            return "HTTP error with status code: \(status)"
        case .decoding(_):
            return "Failed to decode data"
        case .invalidURL:
            return "Invalid URL"
        }
    }
}
