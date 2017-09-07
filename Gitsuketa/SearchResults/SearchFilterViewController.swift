//
//  SearchFilterViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 07.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchFilterViewController: UITableViewController {

    let cellContentInset: UIEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
    static let rangeItems = ["=",">", ">=", "<", "<=", "..", "..*", "*.."]

    var cellContents: [[UIView]] {
        return [
            [createdOrPushedSegmentedControl,
             dateRangeSegmentedControl,
             createdOrPushedTextfield
            ],
            [forkSegmentedControl],
            [numberOfForksSegmentedControl,
             numberOfForksTextfield
            ]
        ]
    }

    // MARK: - Created At / Pushed At

    var createdOrPushedSegmentedControl: UISegmentedControl = {
        let createdOrPushedSegmentedControl = UISegmentedControl(items: ["created", "pushed"])
        createdOrPushedSegmentedControl.accessibilityIdentifier = "createdOrPushed SegmentedControl"
        return createdOrPushedSegmentedControl
    }()

    var dateRangeSegmentedControl: UISegmentedControl = {
        let dateRangeSegmentedControl = UISegmentedControl(items: rangeItems)
        dateRangeSegmentedControl.accessibilityIdentifier = "createdOrPushed dateRange SegmentedControl"
        return dateRangeSegmentedControl
    }()

    var createdOrPushedTextfield: UITextField = {
        let createdOrPushedTextfield = UITextField()
        createdOrPushedTextfield.placeholder = NSLocalizedString("Select Date", comment: "Select Date placeholder text")
        return createdOrPushedTextfield
    }()

    var createdOrPushedDatePicker: UIDatePicker = {
        let createdOrPushedDatePicker = UIDatePicker()
        createdOrPushedDatePicker.datePickerMode = .date
        createdOrPushedDatePicker.accessibilityIdentifier = "createdOrPushed DatePicker"
        return createdOrPushedDatePicker
    }()

    // MARK: - Forked

    var forkSegmentedControl: UISegmentedControl = {
        let forkSegmentedControl = UISegmentedControl(items: ["true", "only"])
        forkSegmentedControl.accessibilityIdentifier = "fork SegmentedControl"
        return forkSegmentedControl
    }()

    // MARK: - Number of forks

    var numberOfForksSegmentedControl: UISegmentedControl = {
        let numberOfForksSegmentedControl = UISegmentedControl(items: rangeItems)
        numberOfForksSegmentedControl.accessibilityIdentifier = "numberOfForks dateRange SegmentedControl"
        return numberOfForksSegmentedControl
    }()

    var numberOfForksTextfield: UITextField = {
        let numberOfForksTextfield = UITextField()
        numberOfForksTextfield.placeholder = NSLocalizedString("Number of forks", comment: "")
        return numberOfForksTextfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done button for dismissing modal view"), style: .done, target: self, action: #selector(SearchFilterViewController.dismissFilter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Reset filter", comment: "Reset filter button"), style: .plain, target: self, action: #selector(SearchFilterViewController.clearFilter))

        createdOrPushedTextfield.inputView = createdOrPushedDatePicker
    }

}

extension SearchFilterViewController {

    @objc func dismissFilter() {
        dismiss(animated: true)
    }

    @objc func clearFilter() {

    }

}

// MARK: - UITableViewDataSource
extension SearchFilterViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellContents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContents[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "filterCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let cellContent = cellContents[indexPath.section][indexPath.row]
        cell.contentView.addSubview(cellContent)
        cell.contentView.constraints(equalToEdgeOf: cellContent, constants: cellContentInset)

        return cell
    }

}
