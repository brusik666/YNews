//
//  NewsRowView.swift
//  YNews
//
//  Created by Brusik on 5/9/25.
//

import SwiftUI
import Foundation

struct NewsRowView: View {
    private let article: NewsArticle

    init(article: NewsArticle) {
        self.article = article
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = article.urlToImage {
                NewsThumbnailView(imageUrlString: imageUrl)
            }

            NewsTextBlockView(article: article)
                .padding(.top, AppSpacing.small)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: AppCornerRadius.medium)
                .fill(Color(.systemBackground))
                .shadow(radius: 3)
        )
        .frame(maxWidth: .infinity)
    }
}



#Preview {
    NewsRowView(article: NewsArticle(
            sourceName: "Preview Source",
            author: "Preview Author",
            title: "Preview Title",
            description: "Preview Description",
            url: "https://example.com",
            urlToImage: "https://picsum.photos/400/200",
            publishedAt: Date(),
            content: "Content here",
            category: .general
        ))
}
