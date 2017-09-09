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

    var currentSearchParameter: GitHubSearchParameter? {
        return _currentSearchParameter
    }
    fileprivate var _currentSearchParameter: GitHubSearchParameter?

    let searchResultsViewController = SearchResultsViewController()
    let searchFilterViewController = SearchFilterViewController(style: .grouped)

    var collectionView: UICollectionView {
        return searchResultsViewController.collectionView!
    }

    var searchController: UISearchController?

    var searchResultsSortingViewController: SearchResultsSortingViewController = {
        let searchResultsSortingViewController = SearchResultsSortingViewController()
        return searchResultsSortingViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.accessibilityIdentifier = "ViewController view"
        searchResultsViewController.view.accessibilityIdentifier = "searchResultsViewController.view"

        definesPresentationContext = true // fixes problem where other VC couldn't be presented after a search

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Filter", comment: "Filter search button"), style: .plain, target: self, action: #selector(ViewController.showFilter))

        searchResultsViewController.didSelectRowAction = {
            url in
            guard let url = url, let urlObject = URL(string: url) else {
                assertionFailure()
                return
            }
            let safari = SFSafariViewController(url: urlObject)
            self.present(safari, animated: true, completion: nil)
        }

        if let defaultSearchKeyword = self.defaultSearchKeyword {
            startSearch(searchKeyword: defaultSearchKeyword)
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
        searchBar.placeholder = NSLocalizedString("Search GitHub repositories", comment: "")
        searchBarContainerView.addSubview(searchBar)

        searchResultsSortingViewController.delegate = self
        addChildViewController(searchResultsSortingViewController)
        guard let sortingBar = searchResultsSortingViewController.view else {
            assertionFailure()
            return
        }
        view.addSubview(sortingBar)
        sortingBar.translatesAutoresizingMaskIntoConstraints = false

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

        searchBarContainerView.bottomAnchor.constraint(equalTo: sortingBar.topAnchor).isActive = true
        sortingBar.bottomAnchor.constraint(equalTo: searchResultsView.topAnchor).isActive = true
        sortingBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        sortingBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        searchResultsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchResultsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchResultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        searchFilterViewController.dismissAction = {
            vc in
            var filteredQuery = SearchFilterReader.read(searchFilterViewController: vc)
            filteredQuery.keyword = searchBar.text
            self.startSearch(searchQuery: filteredQuery)
        }
    }

}

extension ViewController: UISearchResultsUpdating {

    fileprivate func startSearch(searchParameter: GitHubSearchParameter) {
        _currentSearchParameter = searchParameter

        GitHubRequest.makeRequest(search: searchParameter) {
            [weak searchResultsViewController, weak collectionView] searchResult in

            guard let searchResult = searchResult else {
                print("No search results. Possibly exceeded API limit. ")
                return
            }

            DispatchQueue.main.sync {
                let formattedData = SearchResultsFormatter(gitHubSearchResult: searchResult)
                searchResultsViewController?.searchResults = formattedData

                collectionView?.reloadData()
            }
        }
    }

    fileprivate func startSearch(searchQuery: GitHubSearchQuery) {
        let parameter: GitHubSearchParameter

        if let currentSearchParameter = currentSearchParameter {
            var newParameter = currentSearchParameter
            newParameter.query = searchQuery
            parameter = newParameter
        } else {
            parameter = GitHubSearchParameter(query: searchQuery)
        }
        startSearch(searchParameter: parameter)
    }

    fileprivate func startSearch(searchKeyword: String) {
        let query = GitHubSearchQuery(keyword: searchKeyword)
        startSearch(searchQuery: query)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else {
            return
        }

        if searchQuery.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            return
        }

        startSearch(searchKeyword: searchQuery)
    }

}

extension ViewController {

    @objc func showFilter() {
        let searchText = searchController?.searchBar.text
        searchController?.isActive = false
        searchController?.searchBar.text = searchText
        
        let filterNavigationcontroller = UINavigationController(rootViewController: searchFilterViewController)
        present(filterNavigationcontroller, animated: true)
    }

}

extension ViewController: SearchResultsSortingDelegate {

    func searchResultsSortingViewController(_ searchResultsSortingViewController: SearchResultsSortingViewController, didSelectSortingOption sortingOption: GitHubSortingOption) {
        guard let currentSearchParameter = currentSearchParameter else {
            return
        }
        var sortedSearchParameter = currentSearchParameter
        sortedSearchParameter.sortingOption = sortingOption
        startSearch(searchParameter: sortedSearchParameter)
    }

}
