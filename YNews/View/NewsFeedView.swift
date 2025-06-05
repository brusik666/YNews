//
//  NewsFeedView.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import SwiftUI

struct NewsFeedView<ViewModel: NewsFeedViewModel>: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject var coordinator: MainCoordinator

    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            content
        }
        .navigationTitle("Top Headlines")
        .task {
            await viewModel.loadNews()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            ProgressView("Preparing...")
                .maxFrame()
        case .loading:
            ProgressView("Fetching News")
                .maxFrame()
        case .loaded(let articles):
            List(articles) { article in
                NewsRowView(article: article)
                    .onTapGesture {
                        coordinator.navigate(to: .detail(article))
                    }
            }
            .listStyle(.plain)
        case .failed(let error):
            VStack(spacing: AppSpacing.medium) {
                Text("Failed to load news.")
                    .font(.headline)
                Text(error.localizedDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Button("Retry") {
                    Task {
                        await viewModel.loadNews()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .maxFrame()
            .multilineTextAlignment(.center)
            .background(Color.red.opacity(0.1))
            .ignoresSafeArea()

        }
    }
}


struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        let api = NewsAPIService()
        let viewModel = DefaultNewsFeedViewModel(newsService: api, country: .us, category: .health)
        //let mockViewModel = MockNewsFeedViewModel()
        NewsFeedView(viewModel: viewModel)
    }
}


