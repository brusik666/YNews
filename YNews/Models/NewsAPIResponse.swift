//
//  NewsAPIResponse.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

struct NewsAPIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleRaw]
}

struct ArticleRaw: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}

