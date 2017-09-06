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
    let query: GitHubSearchQuery
    let sort: GitHubSort
    let order: GitHubOrder
}

struct GitHubSearchQuery {
    let query: String
//    let created: Date
//    let pushed: Date
//    let fork:
//    let forks:
//    let in:
//    let language:
//    let repo:
//    let size:
//    let stars:
//    let topic:
}

enum GitHubSort: String {
    case match, stars, forks, updated
}

enum GitHubOrder: String {
    case ascending = "asc"
    case descending = "desc"
}
