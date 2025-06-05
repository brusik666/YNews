//
//  NewsDetailView.swift
//  YNews
//
//  Created by Brusik on 5/19/25.
//

import SwiftUI

struct NewsDetailView: View {
    let article: NewsArticle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                if let imageUrl = article.urlToImage,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(AppCornerRadius.large)
                }

                Text(article.title)
                    .font(.title2)
                    .bold()

                Text("By \(article.author ?? "Unknown") • \(article.sourceName)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(article.content ?? article.description ?? "")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    
    let previewArticle = NewsArticle(
        sourceName: "YNews Times",
        author: "Jane Swift",
        title: "SwiftUI 5.0 Revolutionizes iOS Development",
        description: "Apple introduces new SwiftUI features that streamline UI building and state management.",
        url: "https://example.com/swiftui5",
        urlToImage: "https://picsum.photos/400/200",
        publishedAt: Date(),
        content: """
    SwiftUI 5.0 introduces powerful enhancements including data-driven navigation, advanced animations, and improved integration with UIKit. Developers are praising the framework for reducing boilerplate and increasing development speed. Experts believe SwiftUI is now mature enough for production apps across Apple platforms.
    """,
        category: .technology
    )
    
    NavigationStack {
        NewsDetailView(article: previewArticle)
    }
    
}
