//
//  GitHubSortingOption.swift
//  Gitsuketa
//
//  Created by Maddin on 09.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

enum GitHubSortingOption {

    case bestMatch
    case mostStars
    case fewestStars
    case mostForks
    case fewestForks
    case recentlyUpdated
    case leastRecentlyUpdated

    var stringValue: String {
        let (sort, order) = self.sortOrderPair
        return "&sort=\(sort.rawValue)&order=\(order.rawValue)"
    }

    private var sortOrderPair: (GitHubSort, GitHubOrder) {
        switch self {
        case .bestMatch:
            return (.match, .descending)
        case .mostStars:
            return (.stars, .descending)
        case .fewestStars:
            return (.stars, .ascending)
        case .mostForks:
            return (.forks, .descending)
        case .fewestForks:
            return (.forks, .ascending)
        case .recentlyUpdated:
            return (.updated, .descending)
        case .leastRecentlyUpdated:
            return (.updated, .ascending)
        }
    }

    var description: String {
        switch self {
        case .bestMatch:
            return NSLocalizedString("Best match", comment: "")
        case .mostStars:
            return NSLocalizedString("Most stars", comment: "")
        case .fewestStars:
            return NSLocalizedString("Fewest stars", comment: "")
        case .mostForks:
            return NSLocalizedString("Most forks", comment: "")
        case .fewestForks:
            return NSLocalizedString("Fewest forks", comment: "")
        case .recentlyUpdated:
            return NSLocalizedString("Recently updated", comment: "")
        case .leastRecentlyUpdated:
            return NSLocalizedString("Least recently updated", comment: "")
        }
    }

    static var allValues: [GitHubSortingOption] {
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
}

enum GitHubOrder: String {
    case ascending = "asc"
    case descending = "desc"
}
