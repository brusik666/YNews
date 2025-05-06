//
//  NewsFeedState.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

enum NewsFeedState {
    case idle
    case loading
    case loaded([NewsArticle])
    case failed(Error)
}

