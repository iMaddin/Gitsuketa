//
//  SearchFilterViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 07.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchFilterViewController: UITableViewController {

    var createdOrPushedStackView: UIStackView = {
        let createdOrPushedStackView = UIStackView()
        createdOrPushedStackView.translatesAutoresizingMaskIntoConstraints = false
        createdOrPushedStackView.distribution = .fillEqually
        return createdOrPushedStackView
    }()

    var createdOrPushedSegmentedControl: UISegmentedControl = {
        let createdOrPushedSegmentedControl = UISegmentedControl(items: ["created at", "pushed at"])
        createdOrPushedSegmentedControl.accessibilityIdentifier = "createdOrPushed SegmentedControl"
        return createdOrPushedSegmentedControl
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
        createdOrPushedStackView.addArrangedSubview(createdOrPushedSegmentedControl)
        createdOrPushedStackView.addArrangedSubview(createdOrPushedTextfield)
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "filterCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        switch(indexPath.row) {
        case 0:
            cell.contentView.addSubview(createdOrPushedStackView)
            cell.contentView.constraints(equalToEdgeOf: createdOrPushedStackView, constants: UIEdgeInsetsMake(15, 15, 15, 15))
        default:
            break
        }

        return cell
    }

}

}
