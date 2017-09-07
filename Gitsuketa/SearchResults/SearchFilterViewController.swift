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
             createdOrPushedTextfield],
            [forkSegmentedControl],
            [numberOfForksSegmentedControl,
             numberOfForksTextfield],
            [searchInRepositoryName,
             searchInDescription,
             searchInReadme],
            [languagesTextField],
            [orgOrUserSegmentedControl,
             orgOrUserTextField],
            [sizeSegmentedControl,
             sizeTextfield],
            [numberOfStarsSegmentedControl,
             numberOfStarsTextfield],
            [topicsTextfield]
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

    // MARK: - Search in repository name, description, README

    var searchInRepositoryName: UIButton = {
        let searchInRepositoryName = UIButton()
        searchInRepositoryName.setTitleColor(UIColor.black, for: .normal)
        searchInRepositoryName.setTitle(NSLocalizedString("⭕️ Repository Name", comment: ""), for: .normal)
        searchInRepositoryName.contentHorizontalAlignment = .leading
        searchInRepositoryName.addTarget(self, action: #selector(SearchFilterViewController.toggleButton(sender:)), for: .touchUpInside)
        return searchInRepositoryName
    }()

    var searchInDescription: UIButton = {
        let searchInDescription = UIButton()
        searchInDescription.setTitleColor(UIColor.black, for: .normal)
        searchInDescription.setTitle(NSLocalizedString("⭕️ Description", comment: ""), for: .normal)
        searchInDescription.contentHorizontalAlignment = .leading
        searchInDescription.addTarget(self, action: #selector(SearchFilterViewController.toggleButton(sender:)), for: .touchUpInside)
        return searchInDescription
    }()

    var searchInReadme: UIButton = {
        let searchInReadme = UIButton()
        searchInReadme.setTitleColor(UIColor.black, for: .normal)
        searchInReadme.setTitle(NSLocalizedString("⭕️ Readme", comment: ""), for: .normal)
        searchInReadme.contentHorizontalAlignment = .leading
        searchInReadme.addTarget(self, action: #selector(SearchFilterViewController.toggleButton(sender:)), for: .touchUpInside)
        return searchInReadme
    }()

    // MARK: - Languages

    var languagesTextField: UITextField = {
        let languagesTextField = UITextField()
        languagesTextField.placeholder = NSLocalizedString("Language", comment: "")
        return languagesTextField
    }()

    var languagesPicker: UIPickerView = {
        let languagesPicker = UIPickerView()
        return languagesPicker
    }()

    // MARK: - Organization or User repositories

    var orgOrUserSegmentedControl: UISegmentedControl = {
        let orgOrUserSegmentedControl = UISegmentedControl(items: ["organization", "user"])
        orgOrUserSegmentedControl.accessibilityIdentifier = "orgOrUser SegmentedControl"
        return orgOrUserSegmentedControl
    }()
    
    var orgOrUserTextField: UITextField = {
        let orgOrUserTextField = UITextField()
        orgOrUserTextField.placeholder = NSLocalizedString("Organization / User name", comment: "") // TODO: change placeholder depeing on what is selected in orgOrUserSegmentedControl
        return orgOrUserTextField
    }()

    // MARK: - Size in KB

    var sizeSegmentedControl: UISegmentedControl = {
        let sizeSegmentedControl = UISegmentedControl(items: rangeItems)
        sizeSegmentedControl.accessibilityIdentifier = "size range SegmentedControl"
        return sizeSegmentedControl
    }()

    var sizeTextfield: UITextField = {
        let sizeTextfield = UITextField()
        sizeTextfield.placeholder = NSLocalizedString("Size in KB", comment: "")
        return sizeTextfield
    }()

    // MARK: - Number of stars

    var numberOfStarsSegmentedControl: UISegmentedControl = {
        let numberOfStarsSegmentedControl = UISegmentedControl(items: rangeItems)
        numberOfStarsSegmentedControl.accessibilityIdentifier = "numberOfStars range SegmentedControl"
        return numberOfStarsSegmentedControl
    }()

    var numberOfStarsTextfield: UITextField = {
        let numberOfStarsTextfield = UITextField()
        numberOfStarsTextfield.placeholder = NSLocalizedString("Number of stars", comment: "")
        return numberOfStarsTextfield
    }()

    // MARK: - Topics

    var topicsTextfield: UITextField = {
        let topicsTextfield = UITextField()
        topicsTextfield.placeholder = NSLocalizedString("Topics, e.g. ruby, rails", comment: "")
        return topicsTextfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done button for dismissing modal view"), style: .done, target: self, action: #selector(SearchFilterViewController.dismissFilter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Reset filter", comment: "Reset filter button"), style: .plain, target: self, action: #selector(SearchFilterViewController.clearFilter))

        createdOrPushedTextfield.inputView = createdOrPushedDatePicker

        languagesTextField.inputView = languagesPicker
        languagesPicker.dataSource = self
        languagesPicker.delegate = self
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        let cellContent = cellContents[indexPath.section][indexPath.row]
        cell.contentView.addSubview(cellContent)
        cell.contentView.constraints(equalToEdgeOf: cellContent, constants: cellContentInset)

        return cell
    }

}

// MARK: - Search In button action
extension SearchFilterViewController {

    @objc func toggleButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let oldTitle = sender.title(for: .normal) {
            let newTitle = (sender.isSelected ? "🔴" : "⭕️") + oldTitle.dropFirst()
            sender.setTitle(newTitle, for: .normal)
        }
    }

}

extension SearchFilterViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }

}

extension SearchFilterViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Any"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }

}
