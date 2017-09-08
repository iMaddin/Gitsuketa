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

        for sectionNumber in 0..<searchFilterViewController.tableView.numberOfSections {
            if !searchFilterViewController.sectionIsExpanded(section: sectionNumber) { break }

            switch sectionNumber {
            case 0:
                let value = searchFilterViewController.createdOrPushedDate
                let fromValue = searchFilterViewController.createdOrPushedFromDate
                let rangeSelectionVC = searchFilterViewController.createdOrPushedRangeSelectionViewController!
                let rangeValue = SearchFilterReader.createRangeValue(value: value, fromValue: fromValue, rangeSelectionViewController: rangeSelectionVC)

                if searchFilterViewController.createdOrPushedSegmentedControl.selectedSegmentIndex == 0 {
                    searchQuery.created = rangeValue
                    searchQuery.pushed = nil
                } else {
                    searchQuery.created = nil
                    searchQuery.pushed = rangeValue
                }
            case 1:
                searchQuery.fork = GitHubForkSearchOption.allValues[searchFilterViewController.forkSegmentedControl.selectedSegmentIndex]
            case 2:
                let value = searchFilterViewController.numberOfForksRightTextfield.text
                let fromValue = searchFilterViewController.numberOfForksLeftTextfield.text
                let rangeSelectionVC = searchFilterViewController.numberOfForksRangeSelectionViewController!
                let rangeValue = SearchFilterReader.createRangeValue(value: Int(value!), fromValue: Int(fromValue!), rangeSelectionViewController: rangeSelectionVC)
                searchQuery.numberOfForks = rangeValue
            case 3:
                var searchInArray: [GitHubSearchField] = []

                if searchFilterViewController.searchInRepositoryName.isSelected {
                    searchInArray.append(.repositoryName)
                }
                
                if searchFilterViewController.searchInDescription.isSelected {
                    searchInArray.append(.description)
                }
                
                if searchFilterViewController.searchInReadme.isSelected {
                    searchInArray.append(.readme)
                }

                searchQuery.searchFields = searchInArray
            default:
                break
            }
        }
        return searchQuery
    }

}

fileprivate extension SearchFilterReader {

    static func createRangeValue<T>(value: T?, fromValue: T?, rangeSelectionViewController: RangeSelectionViewController) -> GitHubRangeValue<T>? {
        guard let value = value else {
            return nil
        }

        let rangeValue: GitHubRangeValue<T>
        let selectedRow = rangeSelectionViewController.rangeQualifierPickerView.selectedRow(inComponent: 0)
        let rangeQualifier = GitHubRangeQualifier.allValues[selectedRow]

        if rangeQualifier == .between {
            guard let fromValue = fromValue else {
                assertionFailure()
                return nil
            }

            rangeValue = GitHubRangeValue(value: value, fromValue: fromValue)
        } else {
            rangeValue = GitHubRangeValue(value: value, rangeQualifier: rangeQualifier)
        }
        return rangeValue
    }

}
