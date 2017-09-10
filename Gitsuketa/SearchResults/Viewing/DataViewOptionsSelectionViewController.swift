//
//  DataViewOptionsSelectionViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 10.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class DataViewOptionsSelectionViewController: UITableViewController {

    var didDismiss: ((_: DataViewOptionsSelectionViewController) -> Void)?

    var dataViewOptions: DataViewOptionsManager {
        return _dataViewOptions
    }
    fileprivate var _dataViewOptions = DataViewOptionsManager()

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
        cell.textLabel?.text = DataViewOptions.allValues[indexPath.row].description
        return cell
    }

}

// MARK: - UITableViewDelegate

extension DataViewOptionsSelectionViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        // cell?.accessoryType.rawValue results in "none" which is apparently not == .none
        cell?.accessoryType = cell?.accessoryType.rawValue == UITableViewCellAccessoryType.none.rawValue ? .checkmark : .none
    }

}

// MARK: - fileprivate

fileprivate extension DataViewOptionsSelectionViewController {

    var cellIdentifier: String {
        return "dataViewOptionCell"
    }

    @objc func doneButtonPressed(sender: UIControl?) {
        dismiss(animated: true) {
            [unowned self] in
            self.didDismiss?(self)
        }
    }

}
