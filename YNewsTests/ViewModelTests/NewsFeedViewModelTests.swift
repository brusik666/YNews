//
//  NewsFeedViewModelTests.swift
//  YNewsTests
//
//  Created by Brusik on 6/4/25.
//

import XCTest
@testable import YNews

final class NewsFeedViewModelTests: XCTestCase {

    func testLoadNewsSuccessReturnsLoadedState() async {
        let mockAPI = MockNewsAPI()
        let viewModel = await DefaultNewsFeedViewModel(newsService: mockAPI)

        await viewModel.loadNews()
        let state = await viewModel.state
        switch state {
        case .loaded(let articles):
            XCTAssertEqual(articles.count, 1)
            XCTAssertEqual(articles.first?.title, "Test News")
        default:
            XCTFail("Expected loaded state, got \(state)")
        }
    }
    
    func testLoadNewsFailureReturnsFailedState() async {
        let mockAPI = MockNewsAPI()
        mockAPI.shouldFail = true
        let viewModel = await DefaultNewsFeedViewModel(newsService: mockAPI)

        await viewModel.loadNews()
        let state = await viewModel.state
        switch state {
        case .failed(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("Expected failed state, got \(state)")
        }
    }
    
    func testLoadNewsEmptyReturnsLoadedWithEmptyList() async {
        let mockAPI = MockNewsAPI()
        mockAPI.returnEmpty = true
        let viewModel = await DefaultNewsFeedViewModel(newsService: mockAPI)

        await viewModel.loadNews()
        let state = await viewModel.state
        switch state {
        case .loaded(let articles):
            XCTAssertTrue(articles.isEmpty)
        default:
            XCTFail("Expected loaded state with empty list")
        }
    }


}

