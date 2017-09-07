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

    var createdOrPushedSegmentedControl: UISegmentedControl = {
        let createdOrPushedSegmentedControl = UISegmentedControl(items: ["created", "pushed"])
        createdOrPushedSegmentedControl.accessibilityIdentifier = "createdOrPushed SegmentedControl"
        return createdOrPushedSegmentedControl
    }()

    var dateRangeSegmentedControl: UISegmentedControl = {
        let dateRangeSegmentedControl = UISegmentedControl(items: [">", ">=", "<", "<=", "..", "..*", "*.."])
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
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 10
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "filterCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        switch indexPath.section {
        case 0:
            switch(indexPath.row) {
            case 0:
                cell.contentView.addSubview(createdOrPushedSegmentedControl)
                cell.contentView.constraints(equalToEdgeOf: createdOrPushedSegmentedControl, constants: cellContentInset)
            case 1:
                cell.contentView.addSubview(dateRangeSegmentedControl)
                cell.contentView.constraints(equalToEdgeOf: dateRangeSegmentedControl, constants: cellContentInset)
            case 2:
                cell.contentView.addSubview(createdOrPushedTextfield)
                cell.contentView.constraints(equalToEdgeOf: createdOrPushedTextfield, constants: cellContentInset)
            default:
                break
            }
        default:
            break
        }

        return cell
    }

}
