//
//  GitHubSearchResult.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct GitHubSearchResultItem: Codable {
    let full_name: String
}

struct GitHubSearchResult: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [GitHubSearchResultItem]
}
