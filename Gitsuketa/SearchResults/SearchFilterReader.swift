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
        var searchQuery = GitHubSearchQuery()
        let selectedRow = searchFilterViewController.createdOrPushedRangeSelectionViewController.rangeQualifierPickerView.selectedRow(inComponent: 0)
        let rangeQualifier = GitHubRangeQualifier.allValues[selectedRow]

        for sectionNumber in 0..<searchFilterViewController.tableView.numberOfSections {
            if !searchFilterViewController.sectionIsExpanded(section: sectionNumber) { break }

            switch sectionNumber {
            case 0:
                guard let date = searchFilterViewController.createdOrPushedDate else {
                    break
                }

                let value: GitHubRangeValue<Date>

                if rangeQualifier == .between {
                    guard let fromDate = searchFilterViewController.createdOrPushedFromDate else {
                        assertionFailure()
                        break
                    }

                    value = GitHubRangeValue(value: date, fromValue: fromDate)
                } else {
                    value = GitHubRangeValue(value: date, rangeQualifier: rangeQualifier)
                }

                if searchFilterViewController.createdOrPushedSegmentedControl.selectedSegmentIndex == 0 {
                    searchQuery.created = value
                    searchQuery.pushed = nil
                } else {
                    searchQuery.created = nil
                    searchQuery.pushed = value
                }
            case 1:
                searchQuery.fork = GitHubForkSearchOption.allValues[searchFilterViewController.forkSegmentedControl.selectedSegmentIndex]
            default:
                break
            }
        }
        return searchQuery
    }

}
