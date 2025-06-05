//
//  MockNewsAPI.swift
//  YNewsTests
//
//  Created by Brusik on 6/4/25.
//

import Foundation
@testable import YNews

final class MockNewsAPI: NewsAPI {
    var shouldFail = false
    var returnEmpty = false

    func fetchTopHeadlines(for category: NewsCategory, country: Country) async throws -> [NewsArticle] {
        if shouldFail {
            throw URLError(.notConnectedToInternet)
        }

        if returnEmpty {
            return []
        }

        return [
            NewsArticle(
                sourceName: "Mock Source",
                author: "Jane Doe",
                title: "Test News",
                description: "Description...",
                url: "https://example.com",
                urlToImage: nil,
                publishedAt: Date(),
                content: "Content...",
                category: category
            )
        ]
    }
}
