//
//  GitHubFilter.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

let searchQuery = "https://api.github.com/search/repositories?"
//"q=tetris+language:assembly&sort=stars&order=desc"

struct GitHubSearchParameter {

    var url: URL? {
        let q = "q=\(query.query)"
        let sort = "sort=\(self.sort.rawValue)"
        let order = "order=\(self.order.rawValue)"
        let url = searchQuery + q + "&" + sort + "&" + order
        return URL(string: url)
    }

    let query: GitHubSearchQuery
    let sort: GitHubSort
    let order: GitHubOrder

    init(query: GitHubSearchQuery, sort: GitHubSort = .match, order: GitHubOrder = .descending) {
        self.query = query
        self.sort = sort
        self.order = order
    }

}

struct GitHubSearchQuery {

    var query: String {
        return keyword
    }

    let keyword: String

    var created: GitHubRangeValue<Date>?
    var pushed: GitHubRangeValue<Date>?

    var fork: GitHubForkSearchOption?
    var numberOfForks: GitHubRangeValue<Int>?
    var searchFields: GitHubSearchField?
    var language: GitHubLanguage?

    var repo: String?
    var user: String?

    var size: GitHubRangeValue<Int>?
    var numberOfStars: GitHubRangeValue<Int>?
    var topic: [String]?

    init(keyword: String) {
        self.keyword = keyword.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    }

}

enum GitHubSort: String {
    case match, stars, forks, updated
}

enum GitHubOrder: String {
    case ascending = "asc"
    case descending = "desc"
}
