//
//  MainCoordinator.swift
//  YNews
//
//  Created by Brusik on 6/3/25.
//

import SwiftUI
import Foundation

protocol CoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    func navigate(to route: Route)
    func pop()
    func reset()
}


final class MainCoordinator: CoordinatorProtocol {
    @Published var path = NavigationPath()

    func navigate(to route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func reset() {
        path = NavigationPath()
    }
}

enum Route: Hashable {
    case detail(NewsArticle)
    case explain(NewsArticle)
}


