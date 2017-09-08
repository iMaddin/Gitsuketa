//
//  GitHubSearchResult.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct GitHubSearchResultItem: Codable {
    let fullName: String
    let descriptionText: String?
    let url: String
    let language: String?
    let updatedAt: String
    let stargazersCount: Int

//    var readmeURL: URL?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case descriptionText = "description"
        case url = "html_url"
        case language
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
    }

}

struct GitHubSearchResult: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [GitHubSearchResultItem]
}
