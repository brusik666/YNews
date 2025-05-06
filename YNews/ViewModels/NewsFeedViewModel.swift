//
//  NewsFeedViewModel.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

@MainActor
final class NewsFeedViewModel: ObservableObject {
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
        }
    }
}

