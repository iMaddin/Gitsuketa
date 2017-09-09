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

        let filterButton = UIButton()
        filterButton.setTitle(NSLocalizedString("Filter", comment: "Filter search button"), for: .normal)
        filterButton.addTarget(self, action: #selector(ViewController.showFilter), for: .touchUpInside)
        filterButton.widthAnchor.constraint(equalToConstant: filterButton.intrinsicContentSize.width+20).isActive = true
        filterButton.setTitleColor(view.tintColor, for: .normal)

        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("Search GitHub repositories", comment: "")

        searchResultsSortingViewController.delegate = self
        addChildViewController(searchResultsSortingViewController)
        guard let sortingBar = searchResultsSortingViewController.view else {
            assertionFailure()
            return
        }

        addChildViewController(searchResultsViewController)
        guard let searchResultsView = searchResultsViewController.view else {
            assertionFailure()
            return
        }

        sortingBar.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        sortingBar.setContentHuggingPriority(.defaultHigh, for: .vertical)
        searchResultsView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        searchResultsView.setContentHuggingPriority(.defaultLow, for: .vertical)

        let searchStackView = UIStackView(arrangedSubviews: [searchBar, filterButton])
        searchStackView.alignment = .center

        let contentStackView = UIStackView(arrangedSubviews: [searchStackView, sortingBar, searchResultsView])
        contentStackView.axis = .vertical

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStackView)
        contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        searchFilterViewController.dismissAction = {
            vc in
            var filteredQuery = SearchFilterReader.read(searchFilterViewController: vc)
            filteredQuery.keyword = searchBar.text
            self.startSearch(searchQuery: filteredQuery)
        }
    }

}

fileprivate extension ViewController {
    
    func startSearch(searchParameter: GitHubSearchParameter) {
        _currentSearchParameter = searchParameter

        GitHubRequest.makeRequest(search: searchParameter) {
            [weak searchResultsViewController, weak collectionView] searchResult in

            guard let searchResult = searchResult else {
                print("No search results. Possibly exceeded API limit. ")
                return
            }

            DispatchQueue.main.sync {
                searchResultsViewController?.searchResults = searchResult

                collectionView?.reloadData()
            }
        }
    }

    func startSearch(searchQuery: GitHubSearchQuery) {
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

    func startSearch(searchKeyword: String) {
        let query = GitHubSearchQuery(keyword: searchKeyword)
        startSearch(searchQuery: query)
    }

}

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchQuery = searchText
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
