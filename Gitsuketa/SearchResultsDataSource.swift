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
        cell.textLabel?.text = searchResults?.items[indexPath.row].title

        return cell
    }

}
