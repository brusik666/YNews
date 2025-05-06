//
//  NewsArticle.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

struct NewsArticle: Codable, Identifiable {
    var id: UUID { UUID() }
    
    let sourceName: String
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    let category: NewsCategory
}

extension NewsArticle {
    static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
}
