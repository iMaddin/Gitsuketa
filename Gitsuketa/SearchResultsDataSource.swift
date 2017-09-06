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
    var cellVerticalSpacing: CGFloat = 20
    var cellHorizontalSpacing: CGFloat = 15

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

        let containerView = UIView()
        containerView.accessibilityIdentifier = "containerView"
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 4
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor

        cell.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: cellHorizontalSpacing).isActive = true
        containerView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -cellHorizontalSpacing).isActive = true
        containerView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true

        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical

        cell.contentView.addSubview(contentStackView)
        contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: cellHorizontalSpacing).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -cellHorizontalSpacing).isActive = true
        contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = searchResults?.items[indexPath.section].title
        contentStackView.addArrangedSubview(titleLabel)

        if let description = searchResults?.items[indexPath.section].description {
            let descriptionLabel = UILabel()
            descriptionLabel.text = description
            contentStackView.addArrangedSubview(descriptionLabel)
        }

        return cell
    }

}

extension SearchResultsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellVerticalSpacing
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
