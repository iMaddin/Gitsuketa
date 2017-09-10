//
//  GitHubFilter.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

let searchQuery = "https://api.github.com/search/repositories?"

struct GitHubSearchParameter {

    var url: String {
        let q = "\(query.query)"
        let url = searchQuery + q + sortingOption.stringValue
        return url
    }

    var query: GitHubSearchQuery = GitHubSearchQuery(keyword: "")
    var sortingOption: GitHubSortingOption = .bestMatch

    init(query: GitHubSearchQuery, sortingOption: GitHubSortingOption = .bestMatch) {
        self.query = query
        self.sortingOption = sortingOption
    }

}

struct GitHubSearchQuery {

    var query: String {
        var query = "q="

        if let keyword = keyword {
            query += "\(keyword)"
        }

        if let created = created {
            query += "+created:\(created.stringQualifier)"
        }

        if let pushed = pushed {
            query += "+pushed:\(pushed.stringQualifier)"
        }

        if let fork = fork {
            query += "+fork:\(fork.rawValue)"
        }

        if let numberOfForks = numberOfForks {
            query += "+forks:\(numberOfForks.stringQualifier)"
        }

        if let searchFields = searchFields {
            var inFieldsQuery = ""
            for s in searchFields {
                inFieldsQuery += "\(s.rawValue),"
            }
            let removeLastComma = inFieldsQuery.dropLast()
            query += "+in:\(removeLastComma)"
        }

        if let language = language {
            query += "+language:\(language.rawValue)"
        }

        if let repo = repo {
            query += "+org:\(repo)"
        }

        if let user = user {
            query += "+user:\(user)"
        }

        if let size = size {
            query += "+size:\(size.stringQualifier)"
        }

        if let numberOfStars = numberOfStars {
            query += "+stars:\(numberOfStars.stringQualifier)"
        }

        if let topic = topic {
            for t in topic {
                query += "+topic:\(t)"
            }
        }

        return query
    }

    var keyword: String? {
        didSet {
            self.keyword = keyword?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        }
    }

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

    init(keyword: String? = nil) {
        self.keyword = keyword?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    }

}
