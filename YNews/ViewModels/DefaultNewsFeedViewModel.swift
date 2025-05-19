//
//  NewsFeedViewModel.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

@MainActor
protocol NewsFeedViewModel: ObservableObject {
    var state: NewsFeedState { get }
    func loadNews() async
}


@MainActor
final class DefaultNewsFeedViewModel: NewsFeedViewModel {
    @Published private(set) var state: NewsFeedState = .idle
    private let newsService: NewsAPI
    private let selectedCountry: Country
    private let selectedCategory: NewsCategory
    
    init(
        newsService: NewsAPI = NewsAPIService(),
        country: Country = .us,
        category: NewsCategory = .general
    ) {
        self.newsService = newsService
        self.selectedCountry = country
        self.selectedCategory = category
    }
    
    func loadNews() async {
        state = .loading
        do {
            let articles = try await newsService.fetchTopHeadlines(for: selectedCategory, country: selectedCountry)
            state = .loaded(articles)
        } catch {
            state = .failed(error)
            print(error)
        }
    }
}

final class MockNewsFeedViewModel: NewsFeedViewModel, ObservableObject {
    @Published var state: NewsFeedState = .idle

    func loadNews() async {
        // 
    }

    init() {
        let mockArticles = [
            NewsArticle(
                sourceName: "Mock Source",
                author: "John Doe",
                title: "Breaking News: Something Cool Happened",
                description: "This is a preview of a very interesting article with a picture.",
                url: "https://example.com/article",
                urlToImage: "https://picsum.photos/200",
                publishedAt: Date(),
                content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                category: .general
            )
        ]
        self.state = .loaded(mockArticles)
    }
}


