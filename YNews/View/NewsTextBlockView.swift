//
//  NewsTextBlockView.swift
//  YNews
//
//  Created by Brusik on 5/12/25.
//

import SwiftUI

struct NewsTextBlockView: View {
    private let article: NewsArticle
    
    init(article: NewsArticle) {
        self.article = article
    }
    var body: some View {
        Text(article.title)
            .font(.headline)
        if let description = article.description {
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        Text(article.sourceName)
            .font(.caption)
            .foregroundStyle(.gray)
    }
}

#Preview {
    NewsTextBlockView(article: NewsArticle(
        sourceName: "Preview Source",
        author: "Preview Author",
        title: "Preview Title",
        description: "Preview Description",
        url: "https://example.com",
        urlToImage: nil,
        publishedAt: Date(),
        content: "Content here",
        category: .general
    ))
}
