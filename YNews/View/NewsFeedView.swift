//
//  NewsFeedView.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject private var viewModel: NewsFeedViewModel
    
    init(viewModel: NewsFeedViewModel) {
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
            Text("IDLE")
        case .loading:
            ProgressView("Fetching News")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded(let array):
            Text("loaded")
        case .failed(let error):
            VStack(alignment: .leading) {
                Text("Failed to load news.")
                    .font(.headline)
                Text("\(error.localizedDescription)")
                    .font(.subheadline)
            }
            .background(Color.red)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct NewsFeedView_Previews: PreviewProvider {

    static var previews: some View {
        let api = NewsAPIService()
        let VM = NewsFeedViewModel(newsService: api, country: Country.ua, category: .business)
        NewsFeedView(viewModel: VM)
    }
}

