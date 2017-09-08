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

    static let rangeItems = GitHubRangeQualifier.allQualifierDescriptions

    fileprivate var cellContents: [[UIView]] = []

    var dismissAction: ((_ searchFilterViewController: SearchFilterViewController) -> Void)?

    // MARK: - Created At / Pushed At

    fileprivate weak var createdOrPushedPickerOwner: UIButton?

    var createdOrPushedDate: Date?
    var createdOrPushedFromDate: Date?

    var createdOrPushedRangeSelectionViewController: RangeSelectionViewController!

    var createdOrPushedSegmentedControl: UISegmentedControl = {
        let createdOrPushedSegmentedControl = UISegmentedControl(items: ["created", "pushed"])
        createdOrPushedSegmentedControl.accessibilityIdentifier = "createdOrPushed SegmentedControl"
        createdOrPushedSegmentedControl.selectedSegmentIndex = 0
        return createdOrPushedSegmentedControl
    }()

    var createdOrPushedLeftDateSelectionButton: UIButton = {
        let createdOrPushedFromDateSelectionButton = UIButton()
        createdOrPushedFromDateSelectionButton.setTitle(NSLocalizedString("From Date", comment: "Select Date placeholder text"), for: .normal)
        createdOrPushedFromDateSelectionButton.setTitleColor(UIColor.blue, for: .normal)
        return createdOrPushedFromDateSelectionButton
    }()

    var createdOrPushedRightDateSelectionButton: UIButton = {
        let createdOrPushedDateSelectionButton = UIButton()
        createdOrPushedDateSelectionButton.setTitle(NSLocalizedString("Select Date", comment: "Select Date placeholder text"), for: .normal)
        createdOrPushedDateSelectionButton.setTitleColor(UIColor.blue, for: .normal)
        return createdOrPushedDateSelectionButton
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
        forkSegmentedControl.selectedSegmentIndex = 0
        return forkSegmentedControl
    }()

    // MARK: - Number of forks

    var numberOfForksRangeSelectionViewController: RangeSelectionViewController!

    var numberOfForksRightTextfield: UITextField = {
        let numberOfForksRightTextfield = UITextField()
        numberOfForksRightTextfield.placeholder = NSLocalizedString("Number of forks", comment: "")
        return numberOfForksRightTextfield
    }()

    var numberOfForksLeftTextfield: UITextField = {
        let numberOfForksLeftTextfield = UITextField()
        numberOfForksLeftTextfield.placeholder = NSLocalizedString("Number of forks", comment: "")
        return numberOfForksLeftTextfield
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

    var languagesSelectionButton: UIButton = {
        let languagesSelectionButton = UIButton()
        languagesSelectionButton.setTitle(NSLocalizedString("Language", comment: ""), for: .normal)
        return languagesSelectionButton
    }()

    var languagesPicker: UIPickerView = {
        let languagesPicker = UIPickerView()
        return languagesPicker
    }()

    var languagesPickerManager: LanguagesPickerManager?

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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done button for dismissing modal view"), style: .done, target: self, action: #selector(SearchFilterViewController.dismissFilter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Reset filter", comment: "Reset filter button"), style: .plain, target: self, action: #selector(SearchFilterViewController.clearFilter))

        // created / pushed

        createdOrPushedRangeSelectionViewController = RangeSelectionViewController(leftView: createdOrPushedLeftDateSelectionButton, rightView: createdOrPushedRightDateSelectionButton)

        createdOrPushedRangeSelectionViewController.rangeQualifierButton.addTarget(self, action: #selector(SearchFilterViewController.toggleDateButton(sender:)), for: .touchUpInside)

        // Date picker
        createdOrPushedRightDateSelectionButton.addTarget(self, action: #selector(SearchFilterViewController.toggleDateButton(sender:)), for: .touchUpInside)
        createdOrPushedLeftDateSelectionButton.addTarget(self, action: #selector(SearchFilterViewController.toggleDateButton(sender:)), for: .touchUpInside)
        createdOrPushedDatePicker.addTarget(self, action: #selector(SearchFilterViewController.datePickerDidChangeValue(sender:)), for: .valueChanged)

        // default createdOrPushed date selection button titles
        createdOrPushedDate = createdOrPushedDatePicker.date
        if let createdOrPushedDate = createdOrPushedDate {
            createdOrPushedRightDateSelectionButton.setTitle(dateSelectionFormatter.string(from: createdOrPushedDate), for: .normal)
        }

        createdOrPushedFromDate = createdOrPushedDatePicker.date.addingTimeInterval(-86400)
        if let createdOrPushedFromDate = createdOrPushedFromDate {
            createdOrPushedLeftDateSelectionButton.setTitle(dateSelectionFormatter.string(from: createdOrPushedFromDate), for: .normal)
        }

        // number of forks
        numberOfForksRangeSelectionViewController = RangeSelectionViewController(leftView: numberOfForksLeftTextfield, rightView: numberOfForksRightTextfield)
        if let numberOfForksRangeSelectionViewController = numberOfForksRangeSelectionViewController {
            addChildViewController(numberOfForksRangeSelectionViewController)

            numberOfForksRangeSelectionViewController.rangeQualifierButton.addTarget(self, action: #selector(SearchFilterViewController.toggleRangeSelectionButton(sender:)), for: .touchUpInside)
        }

        // languages

        languagesPickerManager = LanguagesPickerManager(button: languagesSelectionButton)
        languagesPicker.dataSource = languagesPickerManager
        languagesPicker.delegate = languagesPickerManager

        var initialCellContents: [[UIView]] = []

        for i in 0..<expandedCellContents.count {
            initialCellContents.append([viewForSection(title: sectionTitles[i])])
        }

        cellContents = initialCellContents
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
        if indexPath.row == 0 {
            cell.accessoryView = accessoryView(expanded: sectionIsExpanded(section: indexPath.section))
        }

        return cell
    }

}

// MARK: - UITableViewDelegate

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

            tableView.cellForRow(at: indexPath)?.accessoryView = accessoryView(expanded: sectionIsExpanded(section: indexPath.section))
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

// MARK: - Date Picker
extension SearchFilterViewController {

    @objc func toggleDateButton(sender: UIButton) {
        let section = 0

        if createdOrPushedPickerOwner == sender {
            createdOrPushedPickerOwner = nil
            let _ = cellContents[section].popLast()

            let indexPath = IndexPath(row: cellContents[section].count, section: section)
            tableView.deleteRows(at: [indexPath], with: .top)
        } else {

            let pickerToShow: UIView
            var dateToShow: Date?

            switch sender {
            case createdOrPushedLeftDateSelectionButton:
                pickerToShow = createdOrPushedDatePicker
                dateToShow = createdOrPushedFromDate
            case createdOrPushedRightDateSelectionButton:
                pickerToShow = createdOrPushedDatePicker
                dateToShow = createdOrPushedDate
            case createdOrPushedRangeSelectionViewController.rangeQualifierButton:
                pickerToShow = createdOrPushedRangeSelectionViewController.rangeQualifierPickerView
            default:
                assertionFailure()
                pickerToShow = UIPickerView()
                break
            }

            if let dateToShow = dateToShow {
                (pickerToShow as? UIDatePicker)?.setDate(dateToShow, animated: true)
            }

            if createdOrPushedPickerOwner == nil {
                cellContents[section].append(pickerToShow)
                let indexPath = IndexPath(row: cellContents[section].count-1, section: section)
                tableView.insertRows(at: [indexPath], with: .top)
            } else {
                let a = [sender, createdOrPushedPickerOwner]
                let fromDateSelectorToAnotherDateSelector = a.contains(where: { $0 == createdOrPushedLeftDateSelectionButton}) && a.contains(where: { $0 == createdOrPushedRightDateSelectionButton})
                if !fromDateSelectorToAnotherDateSelector {
                    let _ = cellContents[section].popLast()
                    cellContents[section].append(pickerToShow)
                    tableView.reloadData()
                }
            }

            createdOrPushedPickerOwner = sender
        }
    }

    @objc func datePickerDidChangeValue(sender: UIDatePicker) {
        guard let createdOrPushedPickerOwner = createdOrPushedPickerOwner,
            (createdOrPushedPickerOwner == createdOrPushedLeftDateSelectionButton) || ( createdOrPushedPickerOwner == createdOrPushedRightDateSelectionButton) else {
            return
        }

        if createdOrPushedPickerOwner == createdOrPushedRightDateSelectionButton {
            createdOrPushedDate = sender.date
        } else if createdOrPushedPickerOwner == createdOrPushedLeftDateSelectionButton {
            createdOrPushedFromDate = sender.date
        }

        createdOrPushedPickerOwner.setTitle(dateSelectionFormatter.string(from: sender.date), for: .normal)
    }

}

// MARK: Range Selection
extension SearchFilterViewController {

    @objc func toggleRangeSelectionButton(sender: UIButton) {
        let section: Int
        var _rangeSelectionViewController: RangeSelectionViewController?

        switch sender {
        case numberOfForksRangeSelectionViewController.rangeQualifierButton:
            section = 2
            _rangeSelectionViewController = numberOfForksRangeSelectionViewController
        default:
            section = -1
        }

        guard let rangeSelectionViewController = _rangeSelectionViewController else {
            assertionFailure()
            return
        }

        if rangeSelectionViewController.pickerViewIsVisible {
            let _ = cellContents[section].popLast()

            let indexPath = IndexPath(row: cellContents[section].count, section: section)
            tableView.deleteRows(at: [indexPath], with: .top)
        } else {

            cellContents[section].append(rangeSelectionViewController.rangeQualifierPickerView)
            let indexPath = IndexPath(row: cellContents[section].count-1, section: section)
            tableView.insertRows(at: [indexPath], with: .top)
        }

        rangeSelectionViewController.pickerViewIsVisible = !rangeSelectionViewController.pickerViewIsVisible
    }

}

extension SearchFilterViewController {

    func sectionIsExpanded(section: Int) -> Bool {
        return cellContents[section].count != 1
    }

}

fileprivate extension SearchFilterViewController {

    var expandedCellContents: [[UIView]] {
        return [
            [viewForSection(title: sectionTitles[0]),
             createdOrPushedSegmentedControl,
             createdOrPushedRangeSelectionViewController.view],
            [viewForSection(title: sectionTitles[1]),
             forkSegmentedControl],
            [viewForSection(title: sectionTitles[2]),
             numberOfForksRangeSelectionViewController.view],
            [viewForSection(title: sectionTitles[3]),
             searchInRepositoryName,
             searchInDescription,
             searchInReadme],
            [viewForSection(title: sectionTitles[4]),
             languagesSelectionButton],
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

    var sectionTitles: [String] {
        return [
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
    }

    func viewForSection(title: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = title

        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        return stackView
    }

    var dateSelectionFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }

    func accessoryView(expanded: Bool) -> UIView {
        let accessoryView = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        accessoryView.textAlignment = .right
        let t: String = expanded ? "🔽" : "◀️"
        accessoryView.text = t
        return accessoryView
    }

}

