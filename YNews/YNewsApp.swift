//
//  YNewsApp.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import SwiftUI

@main
struct YNewsApp: App {
    var body: some Scene {
        WindowGroup {
            let newsApiService = NewsAPIService()
            NewsFeedView(viewModel: DefaultNewsFeedViewModel(newsService: newsApiService))
        }
    }
}
