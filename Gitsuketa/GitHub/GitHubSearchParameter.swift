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
//    let created: Date? //  ISO8601
//    let pushed: Date?
//    let fork: String?
//    let forks: String?
//    let searchFields: String?
//    let language: String?
//    let repo: String?
//    let user: String?
//    let size: Int?
//    let stars: Int?
//    let topic: [String?]

    public init(keyword: String) {
        self.keyword = keyword
    }

}

public enum GitHubSort: String {
    case match, stars, forks, updated
}

public enum GitHubOrder: String {
    case ascending = "asc"
    case descending = "desc"
}
