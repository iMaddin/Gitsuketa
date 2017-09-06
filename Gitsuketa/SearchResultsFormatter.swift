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

}

extension GitHubSearchResultItem: SearchResultItem {

    var title: String {
        return self.fullName
    }
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
