//
//  DataViewOptions.swift
//  Gitsuketa
//
//  Created by Maddin on 10.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

enum DataViewOptions {

    case createdAt
    case defaultBranch
    case descriptionText
    case fork
    case forks
    case forksCount
    case fullName
    case hasDownloads
    case hasIssues
    case hasPages
    case hasProjects
    case hasReadme
    case hasWiki
    case language
    case name
    case openIssues
    case openIssuesCount
    case owner
    case isPrivate
    case pushedAt
    case score
    case size
    case stargazersCount
    case updatedAt
    case url
    case watchers
    case watchersCount

    var description: String {
        switch self {
        case .createdAt:
            return "createdAt"
        case .defaultBranch:
            return "defaultBranch"
        case .descriptionText:
            return "descriptionText"
        case .fork:
            return "fork"
        case .forks:
            return "forks"
        case .forksCount:
            return "forksCount"
        case .fullName:
            return "fullName"
        case .hasDownloads:
            return "hasDownloads"
        case .hasIssues:
            return "hasIssues"
        case .hasPages:
            return "hasPages"
        case .hasProjects:
            return "hasProjects"
        case .hasReadme:
            return "hasReadme"
        case .hasWiki:
            return "hasWiki"
        case .language:
            return "language"
        case .name:
            return "name"
        case .openIssues:
            return "openIssues"
        case .openIssuesCount:
            return "openIssuesCount"
        case .owner:
            return "owner"
        case .isPrivate:
            return "isPrivate"
        case .pushedAt:
            return "pushedAt"
        case .score:
            return "score"
        case .size:
            return "size"
        case .stargazersCount:
            return "stargazersCount"
        case .updatedAt:
            return "updatedAt"
        case .url:
            return "url"
        case .watchers:
            return "watchers"
        case .watchersCount:
            return "watchersCount"
        }
    }

    static var allValues: [DataViewOptions] {
        return [
            .createdAt,
            .defaultBranch,
            .descriptionText,
            .fork,
            .forks,
            .forksCount,
            .fullName,
            .hasDownloads,
            .hasIssues,
            .hasPages,
            .hasProjects,
            .hasWiki,
            .language,
            .name,
            .openIssues,
            .openIssuesCount,
            .owner,
            .isPrivate,
            .pushedAt,
            .score,
            .size,
            .stargazersCount,
            .updatedAt,
            .url,
            .watchers,
            .watchersCount
        ]
    }
    
}
