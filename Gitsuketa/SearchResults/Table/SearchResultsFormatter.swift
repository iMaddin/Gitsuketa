//
//  SearchResultsFormatter.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

protocol SearchResultItem {

    var title: String { get }
    var description: String? { get }
    var url: String  { get }
    var formattedLanguage: String? { get }
    var formatedUpdatedAt: String  { get }
    var stars: Int  { get }
    var hasReadme: Bool { get }
    
}

extension GitHubSearchResultItem: SearchResultItem {

    var title: String {
        return self.fullName
    }

    var description: String? {
        return self.descriptionText
    }

    var formattedLanguage: String? {
        return self.language
    }

    var formatedUpdatedAt: String {
        guard let formattedDate = ISO8601DateFormatter().date(from: updatedAt) else {
            return updatedAt
        }
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: formattedDate)
    }

    var stars: Int {
        return self.stargazersCount
    }

    var hasReadme: Bool {
        return true
    }

}

protocol SearchResultsFormatting {

    var items: [SearchResultItem] { get }

}

struct SearchResultsFormatter {

    let gitHubSearchResult: GitHubSearchResult

    init(gitHubSearchResult: GitHubSearchResult) {
        self.gitHubSearchResult = gitHubSearchResult
    }

}

extension SearchResultsFormatter: SearchResultsFormatting {

    var items: [SearchResultItem] {
        return gitHubSearchResult.items
    }

}
