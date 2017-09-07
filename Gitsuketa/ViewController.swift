//
//  ViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    // Used to display default search results on app launch. Set to nil to show nothing at launch.
    var defaultSearchKeyword: String? = "Benkio"

    let searchResultsViewController = SearchResultsViewController()
    let searchFilterViewController = SearchFilterViewController()

    var tableView: UITableView {
        return searchResultsViewController.tableView
    }

    let resultsDataSource = SearchResultsDataSource()
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.accessibilityIdentifier = "ViewController view"
        searchResultsViewController.view.accessibilityIdentifier = "searchResultsViewController.view"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Filter", comment: "Filter search button"), style: .plain, target: self, action: #selector(ViewController.showFilter))
        
        searchResultsViewController.tableView.dataSource = resultsDataSource
        searchResultsViewController.tableView.delegate = resultsDataSource
        searchResultsViewController.tableView.separatorStyle = .none

        resultsDataSource.didSelectRowAction = {
            url in
            guard let url = url, let urlObject = URL(string: url) else {
                assertionFailure()
                return
            }
            let safari = SFSafariViewController(url: urlObject)
            self.present(safari, animated: true, completion: nil)
        }

        if let defaultSearchKeyword = self.defaultSearchKeyword {
            startSearch(defaultSearchKeyword)
        }

        let searchController = UISearchController(searchResultsController: nil)
        self.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false // TODO: should be true but UISearchBar behaves strangely with Auto Layout
        searchController.obscuresBackgroundDuringPresentation = false

        let searchBarContainerView = UIView() // add container view to fix strange resizing behaviour of searchbar
        searchBarContainerView.accessibilityIdentifier = "searchBarContainerView"
        searchBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBarContainerView)

        let searchBar = searchController.searchBar
        searchBarContainerView.addSubview(searchBar)

        addChildViewController(searchResultsViewController)
        guard let searchResultsView = searchResultsViewController.view else {
            assertionFailure()
            return
        }
        view.addSubview(searchResultsView)
        searchResultsView.translatesAutoresizingMaskIntoConstraints = false

        searchBarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBarContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBarContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchBarContainerView.heightAnchor.constraint(equalToConstant: searchBar.intrinsicContentSize.height).isActive = true

        searchBarContainerView.bottomAnchor.constraint(equalTo: searchResultsView.topAnchor).isActive = true

        searchResultsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchResultsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchResultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

extension ViewController: UISearchResultsUpdating {

    fileprivate func startSearch(_ searchQuery: String) {
        let query = GitHubSearchQuery(keyword: searchQuery)
        let parameter = GitHubSearchParameter(query: query)

        GitHubRequest.makeRequest(search: parameter) {
            [weak resultsDataSource, weak tableView] searchResult in

            guard let searchResult = searchResult else {
                assertionFailure("No search results")
                return
            }

            let formattedData = SearchResultsFormatter(gitHubSearchResult: searchResult)
            resultsDataSource?.searchResults = formattedData

            DispatchQueue.main.async {
                tableView?.reloadData()
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else {
            return
        }

        if searchQuery.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            return
        }

        startSearch(searchQuery)
    }

}

extension ViewController {

    @objc func showFilter() {
        let filterNavigationcontroller = UINavigationController(rootViewController: searchFilterViewController)
        present(filterNavigationcontroller, animated: true)
    }

}
