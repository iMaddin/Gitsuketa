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

    // MARK: Controllers

    fileprivate let searchResultsViewController = SearchResultsViewController()
    fileprivate let searchFilterViewController = SearchFilterViewController(style: .grouped)

    fileprivate var searchController: UISearchController?

    fileprivate var searchResultsSortingViewController: SearchResultsSortingViewController = {
        let searchResultsSortingViewController = SearchResultsSortingViewController()
        return searchResultsSortingViewController
    }()

    fileprivate let dataViewOptionsSelectionViewController = DataViewOptionsSelectionViewController()

    // MARK: Views

    fileprivate var collectionView: UICollectionView {
        return searchResultsViewController.collectionView!
    }

    fileprivate let filterButton: UIButton = {
        let filterButton = UIButton()
        filterButton.setTitle(NSLocalizedString("Filter", comment: "Filter search button"), for: .normal)
        filterButton.setTitleColor(UIColor.white, for: .normal)
        return filterButton
    }()

    fileprivate let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("Search GitHub repositories", comment: "")
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()

    fileprivate let searchBackgroundView: UIView = {
        let searchBackgroundView = UIView()
        searchBackgroundView.layer.backgroundColor = UIColor.lightGray.cgColor
        return searchBackgroundView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.accessibilityIdentifier = "ViewController.view"
        searchResultsViewController.view.accessibilityIdentifier = "searchResultsViewController.view"

        definesPresentationContext = true // fixes problem where other VC couldn't be presented after a search

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("View Options", comment: ""), style: .plain, target: self, action: #selector(ViewController.showViewOptions))

        if let defaultSearchKeyword = self.defaultSearchKeyword {
            startSearch(searchKeyword: defaultSearchKeyword)
        }

        filterButton.addTarget(self, action: #selector(ViewController.showFilter), for: .touchUpInside)
        filterButton.widthAnchor.constraint(equalToConstant: filterButton.intrinsicContentSize.width+20).isActive = true

        searchBar.delegate = self

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

        let searchStackView = UIStackView(arrangedSubviews: [searchBar, filterButton])
        searchStackView.translatesAutoresizingMaskIntoConstraints = false

        searchBackgroundView.addSubview(searchStackView)
        searchBackgroundView.constraints(equalToEdgeOf: searchStackView)

        let contentStackView = UIStackView(arrangedSubviews: [searchBackgroundView, sortingBar, searchResultsView])
        contentStackView.axis = .vertical
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(contentStackView)
        contentStackView.constraints(equalToEdgeOf: view.safeAreaLayoutGuide)

        sortingBar.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        sortingBar.setContentHuggingPriority(.defaultHigh, for: .vertical)
        searchResultsView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        searchResultsView.setContentHuggingPriority(.defaultLow, for: .vertical)

        searchResultsViewController.didSelectRowAction = {
            url in
            guard let url = url, let urlObject = URL(string: url) else {
                assertionFailure()
                return
            }
            let safari = SFSafariViewController(url: urlObject)
            self.present(safari, animated: true, completion: nil)
        }

        searchFilterViewController.willDismiss = {
            [unowned self] vc in
            var filteredQuery = SearchFilterReader.read(searchFilterViewController: vc)
            filteredQuery.keyword = self.searchBar.text
            self.startSearch(searchQuery: filteredQuery)
            self.tintSearchBar(vc.filtersAreEnabled)
        }

        dataViewOptionsSelectionViewController.willDismiss = {
            vc in
            guard let viewOptions = vc.viewOptions else {
                return

            }
            self.searchResultsViewController.viewOptions = viewOptions
            self.searchResultsViewController.collectionView?.reloadData()
            self.searchResultsViewController.collectionViewLayout.invalidateLayout()
        }
    }

}

// MARK: - Search Helper
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

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchQuery = searchText
        if searchQuery.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
            return
        }

        startSearch(searchKeyword: searchQuery)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

// MARK: - Filter
fileprivate extension ViewController {

    @objc func showFilter() {
        let searchText = searchController?.searchBar.text
        searchController?.isActive = false
        searchController?.searchBar.text = searchText
        
        let filterNavigationcontroller = UINavigationController(rootViewController: searchFilterViewController)
        present(filterNavigationcontroller, animated: true)
    }

    @objc func showViewOptions() {
        dataViewOptionsSelectionViewController.viewOptions = searchResultsViewController.viewOptions
        let navVC = UINavigationController(rootViewController: dataViewOptionsSelectionViewController)
        present(navVC, animated: true)
    }

    func tintSearchBar(_ flag: Bool) {
        searchBackgroundView.layer.backgroundColor = flag ? self.view.tintColor.cgColor : UIColor.lightGray.cgColor
    }

}

// MARK: - SearchResultsSortingDelegate
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
