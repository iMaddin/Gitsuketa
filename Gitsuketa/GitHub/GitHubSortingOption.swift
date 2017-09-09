//
//  GitHubSortingOption.swift
//  Gitsuketa
//
//  Created by Maddin on 09.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

enum GitHubSortingOption: String {

    case bestMatch
    case mostStars
    case fewestStars
    case mostForks
    case fewestForks
    case recentlyUpdated
    case leastRecentlyUpdated

    func description() -> String {
        switch self {
        case .bestMatch:
            return "Best match"
        case .mostStars:
            return "Most stars"
        case .fewestStars:
            return "Fewest stars"
        case .mostForks:
            return "Most forks"
        case .fewestForks:
            return "Fewest forks"
        case .recentlyUpdated:
            return "Recently updated"
        case .leastRecentlyUpdated:
            return "Least recently updated"
        }
    }

    var allValues: [GitHubSortingOption] {
        return [
            .bestMatch,
            .mostStars,
            .fewestStars,
            .mostForks,
            .fewestForks,
            .recentlyUpdated,
            .leastRecentlyUpdated,
        ]
    }

}

enum GitHubSort: String {

    case match, stars, forks, updated

    var allValues: [GitHubSort] {
        return [.match, .stars, .forks, .updated]
    }

    var allSortingOptions: [String] {
        return allValues.map{ $0.rawValue }
    }

}

enum GitHubOrder: String {

    case ascending = "asc"
    case descending = "desc"

    var allValues: [GitHubOrder] {
        return [.ascending, .descending]
    }

    var allOrderingOptions: [String] {
        return allValues.map{ $0.rawValue }
    }

}
