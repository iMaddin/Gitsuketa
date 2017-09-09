//
//  GitHubSearchResult.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct GitHubSearchResultItem: Codable {

    struct GitHubOwner: Codable {
        let login: String?
    }

    let createdAt: String?
    let defaultBranch: String?
    let descriptionText: String?
    let fork: Bool?
    let forks: Int?
    let forksCount: Int?
    let fullName: String?
    let hasDownloads: Bool?
    let hasIssues: Bool?
    let hasPages: Bool?
    let hasProjects: Bool?
    let hasWiki: Bool?
    let language: String?
    let name: String?
    let openIssues: Int?
    let openIssuesCount: Int?
    let owner: GitHubOwner?
    let isPrivate: Bool?
    let pushedAt: String?
    let score: Float?
    let size: Int?
    let stargazersCount: Int?
    let updatedAt: String?
    let url: String?
    let watchers: Int?
    let watchersCount: Int?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case defaultBranch = "default_branch"
        case descriptionText = "description"
        case fork = "fork"
        case forks = "forks"
        case forksCount = "forks_count"
        case fullName = "full_name"
        case hasDownloads = "has_downloads"
        case hasIssues = "has_issues"
        case hasPages = "has_pages"
        case hasProjects = "has_projects"
        case hasWiki = "has_wiki"
        case language = "language"
        case name = "name"
        case openIssues = "open_issues"
        case openIssuesCount = "open_issues_count"
        case owner = "owner"
        case isPrivate = "private"
        case pushedAt = "pushed_at"
        case score = "score"
        case size = "size"
        case stargazersCount = "stargazers_count"
        case updatedAt = "updated_at"
        case url = "html_url"
        case watchers = "watchers"
        case watchersCount = "watchers_count"
    }

}

struct GitHubSearchResult: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [GitHubSearchResultItem]
}
