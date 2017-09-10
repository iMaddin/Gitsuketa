//
//  DataViewOptionsManager.swift
//  Gitsuketa
//
//  Created by Maddin on 10.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct DataViewOptionsManager {

    var createdAt: Bool = false
    var defaultBranch: Bool = false
    var descriptionText: Bool = true
    var fork: Bool = false
    var forks: Bool = false
    var forksCount: Bool = false
    var fullName: Bool = true
    var hasDownloads: Bool = false
    var hasIssues: Bool = false
    var hasPages: Bool = false
    var hasProjects: Bool = false
    var hasReadme: Bool = false
    var hasWiki: Bool = false
    var language: Bool = true
    var name: Bool = false
    var openIssues: Bool = false
    var openIssuesCount: Bool = false
    var owner: Bool = false
    var isPrivate: Bool = false
    var pushedAt: Bool = false
    var score: Bool = false
    var size: Bool = false
    var stargazersCount: Bool = true
    var updatedAt: Bool = true
    var url: Bool = false
    var watchers: Bool = false
    var watchersCount: Bool = false

    func bool(forDataViewOption option: DataViewOptions) -> Bool {
        switch option {
        case .createdAt:
            return createdAt
        case .defaultBranch:
            return defaultBranch
        case .descriptionText:
            return descriptionText
        case .fork:
            return fork
        case .forks:
            return forks
        case .forksCount:
            return forksCount
        case .fullName:
            return fullName
        case .hasDownloads:
            return hasDownloads
        case .hasIssues:
            return hasIssues
        case .hasPages:
            return hasPages
        case .hasProjects:
            return hasProjects
        case .hasReadme:
            return hasReadme
        case .hasWiki:
            return hasWiki
        case .language:
            return language
        case .name:
            return name
        case .openIssues:
            return openIssues
        case .openIssuesCount:
            return openIssuesCount
        case .owner:
            return owner
        case .isPrivate:
            return isPrivate
        case .pushedAt:
            return pushedAt
        case .score:
            return score
        case .size:
            return size
        case .stargazersCount:
            return stargazersCount
        case .updatedAt:
            return updatedAt
        case .url:
            return url
        case .watchers:
            return watchers
        case .watchersCount:
            return watchersCount
        }
    }

    mutating func set(bool: Bool, forDataViewOption option: DataViewOptions) {
        switch option {
        case .createdAt:
            createdAt = bool
        case .defaultBranch:
            defaultBranch = bool
        case .descriptionText:
            descriptionText = bool
        case .fork:
            fork = bool
        case .forks:
            forks = bool
        case .forksCount:
            forksCount = bool
        case .fullName:
            fullName = bool
        case .hasDownloads:
            hasDownloads = bool
        case .hasIssues:
            hasIssues = bool
        case .hasPages:
            hasPages = bool
        case .hasProjects:
            hasProjects = bool
        case .hasReadme:
            hasReadme = bool
        case .hasWiki:
            hasWiki = bool
        case .language:
            language = bool
        case .name:
            name = bool
        case .openIssues:
            openIssues = bool
        case .openIssuesCount:
            openIssuesCount = bool
        case .owner:
            owner = bool
        case .isPrivate:
            isPrivate = bool
        case .pushedAt:
            pushedAt = bool
        case .score:
            score = bool
        case .size:
            size = bool
        case .stargazersCount:
            stargazersCount = bool
        case .updatedAt:
            updatedAt = bool
        case .url:
            url = bool
        case .watchers:
            watchers = bool
        case .watchersCount:
            watchersCount = bool
        }
    }
    
}
