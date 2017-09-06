//
//  ViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let searchResultsViewController = SearchResultsViewController()
    let resultsDataSource = SearchResultsDataSource()
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.accessibilityIdentifier = "ViewController view"
        searchResultsViewController.view.accessibilityIdentifier = "searchResultsViewController.view"

        searchResultsViewController.tableView.dataSource = resultsDataSource

        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        self.searchController = searchController
        searchController.searchResultsUpdater = self

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
    }

}

