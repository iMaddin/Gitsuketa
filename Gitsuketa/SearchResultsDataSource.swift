//
//  SearchResultsDataSource.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

// Spacing between cells in UITableView: https://stackoverflow.com/a/33931591/1016508
class SearchResultsDataSource: NSObject  {

    var searchResults: SearchResultsFormatting?
    var cellSpacing: CGFloat = 20
    
}

extension SearchResultsDataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResults?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "searchResultCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let titleLabel = UITextField()
        titleLabel.accessibilityIdentifier = "titleLabel"
        titleLabel.text = searchResults?.items[indexPath.section].title

        let contentStackView = UIStackView(arrangedSubviews: [titleLabel])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical

        cell.contentView.addSubview(contentStackView)
        contentStackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
        contentStackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true

        return cell
    }

}

extension SearchResultsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacing
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
    }

}
