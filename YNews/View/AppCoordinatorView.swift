//
//  AppCoordinatorView.swift
//  YNews
//
//  Created by Brusik on 6/3/25.
//
import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = MainCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            let newsApiService  = NewsAPIService()
            let NewsFeedViewModel = DefaultNewsFeedViewModel(newsService: newsApiService, country: .us, category: .general)
            NewsFeedView(viewModel: NewsFeedViewModel)
                .environmentObject(coordinator)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .detail(let article):
                        NewsDetailView(article: article)
                    case .explain(let article):
                        EmptyView()
                        //GPTExplainView(article: article)
                    }
                }
        }
    }
}
