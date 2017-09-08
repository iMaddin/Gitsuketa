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
                let intValue = value ?? ""
                let intFromValue = fromValue ?? ""
                let rangeValue = SearchFilterReader.createRangeValue(value: Int(intValue), fromValue: Int(intFromValue), rangeSelectionViewController: rangeSelectionVC)
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
            case 4:
                searchQuery.language = GitHubLanguage.allValues[searchFilterViewController.languagesPicker.selectedRow(inComponent: 0)]
            case 5:
                let input = searchFilterViewController.orgOrUserTextField.text
                if searchFilterViewController.orgOrUserSegmentedControl.selectedSegmentIndex == 0 {
                    searchQuery.repo = input
                    searchQuery.user = nil
                } else {
                    searchQuery.repo = nil
                    searchQuery.user = input
                }
            case 6:
                let value = searchFilterViewController.sizeRightTextfield.text
                let fromValue = searchFilterViewController.sizeLeftTextfield.text
                let rangeSelectionVC = searchFilterViewController.sizeRangeSelectionViewController!
                let intValue = value ?? ""
                let intFromValue = fromValue ?? ""
                let rangeValue = SearchFilterReader.createRangeValue(value: Int(intValue), fromValue: Int(intFromValue), rangeSelectionViewController: rangeSelectionVC)
                searchQuery.size = rangeValue
            case 7:
                let value = searchFilterViewController.starsRightTextfield.text
                let fromValue = searchFilterViewController.starsLeftTextField.text
                let rangeSelectionVC = searchFilterViewController.starsRangeSelectionViewController!
                let intValue = value ?? ""
                let intFromValue = fromValue ?? ""
                let rangeValue = SearchFilterReader.createRangeValue(value: Int(intValue), fromValue: Int(intFromValue), rangeSelectionViewController: rangeSelectionVC)
                searchQuery.numberOfStars = rangeValue
            case 8:
                guard let topics = searchFilterViewController.topicsTextfield.text else { break }
                let set1 = Set(topics.components(separatedBy: ","))
                let set2 = Set(topics.components(separatedBy: " "))
                let unionTopics = Array(set1.union(set2))
                searchQuery.topic = unionTopics
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
