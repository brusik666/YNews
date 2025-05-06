//
//  APIError.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError:
            return "Failed to decode the response"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}
