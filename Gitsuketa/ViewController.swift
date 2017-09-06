//
//  ViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Used to display default search results on app launch. Set to nil to show nothing at launch.
    var defaultSearchKeyword: String? = "Benkio"

    let searchResultsViewController = SearchResultsViewController()
    let resultsDataSource = SearchResultsDataSource()
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.accessibilityIdentifier = "ViewController view"
        searchResultsViewController.view.accessibilityIdentifier = "searchResultsViewController.view"
        
        searchResultsViewController.tableView.dataSource = resultsDataSource
        searchResultsViewController.tableView.delegate = resultsDataSource
        searchResultsViewController.tableView.separatorStyle = .none

        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        self.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false

        let searchBarContainerView = UIView() // add container view to fix strange resizing behaviour of searchbar
        searchBarContainerView.accessibilityIdentifier = "searchBarContainerView"
        searchBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBarContainerView)
        searchBarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarContainerView.heightAnchor.constraint(equalToConstant: 147).isActive = true

        let searchBar = searchController.searchBar
        searchBarContainerView.addSubview(searchBar)

        // default search
        searchController.isActive = defaultSearchKeyword != nil
        searchBar.text = defaultSearchKeyword
    }

}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else {
            return
        }

        if searchQuery.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            return
        }

        let query = GitHubSearchQuery(keyword: searchQuery)
        let parameter = GitHubSearchParameter(query: query)

        GitHubRequest.makeRequest(search: parameter) {
            [weak resultsDataSource] searchResult in

            guard let searchResult = searchResult else {
                assertionFailure("No search results")
                return
            }

            let formattedData = SearchResultsFormatter(gitHubSearchResult: searchResult)
            resultsDataSource?.searchResults = formattedData

            DispatchQueue.main.async {
                guard let tableViewController = searchController.searchResultsController as? UITableViewController else {
                    assertionFailure()
                    return
                }
                tableViewController.tableView.reloadData()
            }
        }
    }

}
