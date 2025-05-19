//
//  NewsAPIService.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

protocol NewsAPI {
    func fetchTopHeadlines(for category: NewsCategory, country: Country) async throws -> [NewsArticle]
}

import Foundation

final class NewsAPIService: NewsAPI {
    private let session: URLSession
    private let apiKey: String
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    init(session: URLSession = .shared, apiKey: String = "26febd2ebb9e467ba086722b1d203c66") { //remove last 6 for correct APIKEY
        self.session = session
        self.apiKey = apiKey
    }
    
    func fetchTopHeadlines(for category: NewsCategory, country: Country) async throws -> [NewsArticle] {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: country.rawValue),
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
            let articles = decodedResponse.articles.map { raw in
                NewsArticle(
                    sourceName: raw.source.name,
                    author: raw.author,
                    title: raw.title,
                    description: raw.description,
                    url: raw.url,
                    urlToImage: raw.urlToImage,
                    publishedAt: Self.parseDate(raw.publishedAt),
                    content: raw.content,
                    category: category
                )
            }
            return articles
        } catch {
            throw APIError.decodingError
        }
    }
    
    private static func parseDate(_ dateString: String) -> Date {
        NewsArticle.dateFormatter.date(from: dateString) ?? Date()
    }
}

