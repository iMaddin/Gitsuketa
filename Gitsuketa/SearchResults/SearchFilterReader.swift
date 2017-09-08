//
//  SearchFilterReader.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct SearchFilterReader {

    static func read(searchFilterViewController: SearchFilterViewController) -> GitHubSearchQuery {
        var searchQuery = GitHubSearchQuery(keyword: "")
        for sectionNumber in 0..<searchFilterViewController.sectionTitles.count {
            switch sectionNumber {
            case 0:
                let rangeQualifier = GitHubRangeQualifier.allQualifiers[searchFilterViewController.dateRangeSegmentedControl.selectedSegmentIndex]
                guard let date = searchFilterViewController.createdOrPushedDate else {
                    break
                }
                let value = GitHubRangeValue(value: date, rangeQualifier: rangeQualifier)

                if searchFilterViewController.createdOrPushedSegmentedControl.selectedSegmentIndex == 0 {
                    searchQuery.created = value
                    searchQuery.pushed = nil
                } else {
                    searchQuery.created = nil
                    searchQuery.pushed = value
                }
            default:
                break
            }
        }
        return searchQuery
    }

}
