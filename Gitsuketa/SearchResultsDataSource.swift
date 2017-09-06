//
//  SearchResultsDataSource.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject  {

    var searchResults: SearchResultsFormatting?

}

extension SearchResultsDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "searchResultCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let titleLabel = UITextField()
        titleLabel.accessibilityIdentifier = "titleLabel"
        titleLabel.text = searchResults?.items[indexPath.row].title

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
