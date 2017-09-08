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

public struct GitHubSearchParameter {

    public var url: URL? {
        let q = "q=\(query.query)"
        let sort = "sort=\(self.sort.rawValue)"
        let order = "order=\(self.order.rawValue)"
        let url = searchQuery + q + "&" + sort + "&" + order
        return URL(string: url)
    }

    public let query: GitHubSearchQuery
    public let sort: GitHubSort
    public let order: GitHubOrder

    public init(query: GitHubSearchQuery, sort: GitHubSort = .match, order: GitHubOrder = .descending) {
        self.query = query
        self.sort = sort
        self.order = order
    }

}

public struct GitHubSearchQuery {

    var query: String {
        return keyword
    }

    public let keyword: String

    var created: GitHubDate?
    var pushed: GitHubDate?

    var fork: GitHubForkSearchOption?
    var numberOfForks: GitHubInt?
    var searchFields: GitHubSearchField?
    var language: GitHubLanguage?

    var repo: String?
    var user: String?

    var size: GitHubInt?
    var numberOfStars: GitHubInt?
    var topic: [String]?

    public init(keyword: String) {
        self.keyword = keyword.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    }

}

public enum GitHubSort: String {
    case match, stars, forks, updated
}

public enum GitHubOrder: String {
    case ascending = "asc"
    case descending = "desc"
}
