//
//  SearchFilterViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 07.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchFilterViewController: UITableViewController {

    var dismissAction: ((_ searchFilterViewController: SearchFilterViewController) -> Void)?
    
    let cellContentInset: UIEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15)
    static let rangeItems = GitHubRangeQualifier.allQualifierDescriptions

    var cellContents: [[UIView]] = []

    var expandedCellContents: [[UIView]] {
        return [
            [viewForSection(title: sectionTitles[0]),
             createdOrPushedSegmentedControl,
             createdOrPushedDateInputStackView],
            [viewForSection(title: sectionTitles[1]),
             forkSegmentedControl],
            [viewForSection(title: sectionTitles[2]),
             numberOfForksSegmentedControl,
             numberOfForksTextfield],
            [viewForSection(title: sectionTitles[3]),
             searchInRepositoryName,
             searchInDescription,
             searchInReadme],
            [viewForSection(title: sectionTitles[4]),
             languagesTextField],
            [viewForSection(title: sectionTitles[5]),
             orgOrUserSegmentedControl,
             orgOrUserTextField],
            [viewForSection(title: sectionTitles[6]),
             sizeSegmentedControl,
             sizeTextfield],
            [viewForSection(title: sectionTitles[7]),
             numberOfStarsSegmentedControl,
             numberOfStarsTextfield],
            [viewForSection(title: sectionTitles[8]),
             topicsTextfield]
        ]
    }

    let sectionTitles = [
        NSLocalizedString("Date", comment: ""),
        NSLocalizedString("Fork", comment: ""),
        NSLocalizedString("Number of Forks", comment: ""),
        NSLocalizedString("Search in", comment: ""),
        NSLocalizedString("Language", comment: ""),
        NSLocalizedString("Organization / User", comment: ""),
        NSLocalizedString("Size", comment: ""),
        NSLocalizedString("Stars", comment: ""),
        NSLocalizedString("Topics", comment: ""),
        ]

    // MARK: - Created At / Pushed At

    var createdOrPushedSegmentedControl: UISegmentedControl = {
        let createdOrPushedSegmentedControl = UISegmentedControl(items: ["created", "pushed"])
        createdOrPushedSegmentedControl.accessibilityIdentifier = "createdOrPushed SegmentedControl"
        createdOrPushedSegmentedControl.selectedSegmentIndex = 0
        return createdOrPushedSegmentedControl
    }()

    var createdOrPushedDateInputStackView: UIStackView = {
        let createdOrPushedDateInputStackView = UIStackView()
        return createdOrPushedDateInputStackView
    }()

    var createdOrPushedDateSelectionButton: UIButton = {
        let createdOrPushedDateSelectionButton = UIButton()
        createdOrPushedDateSelectionButton.setTitle(NSLocalizedString("Select Date", comment: "Select Date placeholder text"), for: .normal)
        createdOrPushedDateSelectionButton.setTitleColor(UIColor.blue, for: .normal)
        return createdOrPushedDateSelectionButton
    }()

    var createdOrPushedRangeQualifierButton: UIButton = {
        let createdOrPushedRangeQualifierButton = UIButton()
        createdOrPushedRangeQualifierButton.setTitle(NSLocalizedString("=", comment: "Select Date placeholder text"), for: .normal)
        createdOrPushedRangeQualifierButton.setTitleColor(UIColor.blue, for: .normal)
        return createdOrPushedRangeQualifierButton
    }()

    var createdOrPushedRangeQualifierPickerView: UIPickerView = {
        let createdOrPushedRangeQualifierPickerView = UIPickerView()
        createdOrPushedRangeQualifierPickerView.accessibilityIdentifier = "createdOrPushed dateRange SegmentedControl"
        return createdOrPushedRangeQualifierPickerView
    }()

    var createdOrPushedRangeQualifierPickerManager: RangeQualifierPickerManager?

    var createdOrPushedDatePicker: UIDatePicker = {
        let createdOrPushedDatePicker = UIDatePicker()
        createdOrPushedDatePicker.datePickerMode = .date
        createdOrPushedDatePicker.accessibilityIdentifier = "createdOrPushed DatePicker"
        return createdOrPushedDatePicker
    }()

    var createdOrPushedDate: Date?

    // MARK: - Forked

    var forkSegmentedControl: UISegmentedControl = {
        let forkSegmentedControl = UISegmentedControl(items: ["true", "only"])
        forkSegmentedControl.accessibilityIdentifier = "fork SegmentedControl"
        forkSegmentedControl.selectedSegmentIndex = 0
        return forkSegmentedControl
    }()

    // MARK: - Number of forks

    var numberOfForksSegmentedControl: UISegmentedControl = {
        let numberOfForksSegmentedControl = UISegmentedControl(items: rangeItems)
        numberOfForksSegmentedControl.accessibilityIdentifier = "numberOfForks dateRange SegmentedControl"
        numberOfForksSegmentedControl.selectedSegmentIndex = 0
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
        orgOrUserSegmentedControl.selectedSegmentIndex = 0
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
        sizeSegmentedControl.selectedSegmentIndex = 0
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
        numberOfStarsSegmentedControl.selectedSegmentIndex = 0
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

        var initialCellContents: [[UIView]] = []

        for i in 0..<expandedCellContents.count {
            initialCellContents.append([viewForSection(title: sectionTitles[i])])
        }

        cellContents = initialCellContents

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done button for dismissing modal view"), style: .done, target: self, action: #selector(SearchFilterViewController.dismissFilter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Reset filter", comment: "Reset filter button"), style: .plain, target: self, action: #selector(SearchFilterViewController.clearFilter))

        createdOrPushedDateInputStackView.addArrangedSubview(createdOrPushedRangeQualifierButton)
        createdOrPushedDateInputStackView.addArrangedSubview(createdOrPushedDateSelectionButton)
        createdOrPushedDateSelectionButton.addTarget(self, action: #selector(SearchFilterViewController.toggleDateButton(sender:)), for: .touchUpInside)
        createdOrPushedDatePicker.addTarget(self, action: #selector(SearchFilterViewController.datePickerDidChangeValue(sender:)), for: .valueChanged)

        createdOrPushedRangeQualifierPickerManager = RangeQualifierPickerManager(button: createdOrPushedRangeQualifierButton)
        createdOrPushedRangeQualifierPickerView.dataSource = createdOrPushedRangeQualifierPickerManager
        createdOrPushedRangeQualifierPickerView.delegate = createdOrPushedRangeQualifierPickerManager

        languagesPicker.dataSource = self
        languagesPicker.delegate = self
    }

}

extension SearchFilterViewController {

    @objc func dismissFilter() {
        dismiss(animated: true) {
            [unowned self] in
            self.dismissAction?(self)
        }
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

extension SearchFilterViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            var indexPaths: [IndexPath] = []
            let max: Int

            if sectionIsExpanded(section: indexPath.section) {
                cellContents[indexPath.section] = [cellContents[indexPath.section][0]]

                max = tableView.numberOfRows(inSection: indexPath.section)
                for i in 1..<max {
                    indexPaths.append(IndexPath(row: i, section: indexPath.section))
                }

                tableView.deleteRows(at: indexPaths, with: .top)
            } else {
                cellContents[indexPath.section] = expandedCellContents[indexPath.section]

                max = expandedCellContents[indexPath.section].count
                for i in 1..<max {
                    indexPaths.append(IndexPath(row: i, section: indexPath.section))
                }

                tableView.insertRows(at: indexPaths, with: .top)
            }


        }
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

// MARK: - Date Picker
extension SearchFilterViewController {

    @objc func toggleDateButton(sender: UIButton) {
        let section = 0

        if cellContents[section].last != createdOrPushedDatePicker {
            cellContents[section].append(createdOrPushedDatePicker)

            let indexPath = IndexPath(row: cellContents[section].count-1, section: section)
            tableView.insertRows(at: [indexPath], with: .top)
        } else {
            let _ = cellContents[0].popLast()

            let indexPath = IndexPath(row: cellContents[section].count, section: section)
            tableView.deleteRows(at: [indexPath], with: .top)
        }

    }

    @objc func datePickerDidChangeValue(sender: UIDatePicker) {

    }

}

extension SearchFilterViewController {

    func viewForSection(title: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = title

        let isSelectedIndicator = UILabel()
        isSelectedIndicator.text = "▲"
        isSelectedIndicator.textAlignment = .right

        let stackView = UIStackView(arrangedSubviews: [titleLabel, isSelectedIndicator])
        return stackView
    }

    func sectionIsExpanded(section: Int) -> Bool {
        return cellContents[section].count != 1
    }

}

