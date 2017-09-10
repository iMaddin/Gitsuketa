//
//  DataViewOptionsSelectionViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 10.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

final class DataViewOptionsSelectionViewController: UITableViewController, ViewControllerDismissing {

    var willDismiss: ((DataViewOptionsSelectionViewController) -> Void)?

    var viewOptions: DataViewOptionsManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.title = NSLocalizedString("Display Options", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(DataViewOptionsSelectionViewController.doneButtonPressed(sender:)))
    }

}

// MARK: - UITableViewDataSource
extension DataViewOptionsSelectionViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataViewOptions.allValues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let option = DataViewOptions.allValues[indexPath.row]
        cell.textLabel?.text = option.description

        if let b = viewOptions?.bool(forDataViewOption: option) {
            cell.accessoryType =  b ? .checkmark : .none
        }

        return cell
    }

}

// MARK: - UITableViewDelegate
extension DataViewOptionsSelectionViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let enabled = cell?.accessoryType.rawValue == UITableViewCellAccessoryType.none.rawValue
        // cell?.accessoryType.rawValue results in "none" which is apparently not == .none
        cell?.accessoryType = enabled ? .checkmark : .none
        viewOptions?.set(bool: enabled, forDataViewOption: DataViewOptions.allValues[indexPath.row])
    }

}

// MARK: - fileprivate
fileprivate extension DataViewOptionsSelectionViewController {

    var cellIdentifier: String {
        return "dataViewOptionCell"
    }

    @objc func doneButtonPressed(sender: UIControl?) {
        willDismiss?(self)
        dismiss(animated: true)
    }

}
