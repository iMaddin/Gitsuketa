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
        let q = "\(query.query)"
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
        var query = "q="

         if let keyword = keyword {
            query += "\(keyword)"
         }

         if let created = created {
            query += "+created:\(created)"
         }

         if let pushed = pushed {
            query += "+pushed:\(pushed)"
         }

         if let fork = fork {
            query += "+fork:\(fork)"
         }

         if let numberOfForks = numberOfForks {
            query += "+forks:\(numberOfForks)"
         }

         if let searchFields = searchFields {
            var inFieldsQuery = ""
            for s in searchFields {
                inFieldsQuery += "\(s),"
            }
            let removeLastComma = inFieldsQuery.dropLast()
            query += "+in:\(removeLastComma)"
         }

         if let language = language {
            query += "+language:\(language)"
         }

         if let repo = repo {
            query += "+repo:\(repo)"
         }

         if let user = user {
            query += "+user:\(user)"
         }

         if let size = size {
            query += "+size:\(size)"
         }

         if let numberOfStars = numberOfStars {
            query += "+stars:\(numberOfStars)"
         }

         if let topic = topic {
            for t in topic {
                query += "+topic:\(t)"
            }
         }

        return query
    }

    let keyword: String

    var created: GitHubRangeValue<Date>?
    var pushed: GitHubRangeValue<Date>?

    var fork: GitHubForkSearchOption?
    var numberOfForks: GitHubRangeValue<Int>?
    var searchFields: [GitHubSearchField]?
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
