//
//  SearchFilterViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 07.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

final class SearchFilterViewController: UITableViewController, ViewControllerDismissing {

    var willDismiss: ((SearchFilterViewController) -> Void)?

    var filtersAreEnabled: Bool {
        for i in 0..<sectionTitles.count {
            if sectionIsExpanded(section: i) {
                return true
            }
        }
        return false
    }

    fileprivate var cellContents: [[UIView]] = []

    fileprivate var keyboardAccessoryView: UIView = {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(SearchFilterViewController.dismissKeyboard(sender:)))
        let keyboardAccessoryView = UIToolbar()
        keyboardAccessoryView.setItems([flexibleSpace, doneButton], animated: true)
        keyboardAccessoryView.sizeToFit()
        return keyboardAccessoryView
    }()

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
        let forkSegmentedControl = UISegmentedControl(items: GitHubForkSearchOption.allValues.map{ $0.description() })
        forkSegmentedControl.accessibilityIdentifier = "fork SegmentedControl"
        forkSegmentedControl.selectedSegmentIndex = 0
        return forkSegmentedControl
    }()

    // MARK: - Number of forks

    var numberOfForksRangeSelectionViewController: RangeSelectionViewController!

    var numberOfForksRightTextfield: UITextField = {
        let numberOfForksRightTextfield = UITextField()
        numberOfForksRightTextfield.placeholder = NSLocalizedString("Number of forks", comment: "")
        numberOfForksRightTextfield.keyboardType = .numberPad
        return numberOfForksRightTextfield
    }()

    var numberOfForksLeftTextfield: UITextField = {
        let numberOfForksLeftTextfield = UITextField()
        numberOfForksLeftTextfield.placeholder = NSLocalizedString("Number of forks", comment: "")
        numberOfForksLeftTextfield.keyboardType = .numberPad
        return numberOfForksLeftTextfield
    }()

    // MARK: - Search in repository name, description, README

    var searchInRepositoryName: UIButton = {
        let searchInRepositoryName = UIButton()
        searchInRepositoryName.setTitleColor(UIColor.black, for: .normal)
        searchInRepositoryName.setTitle(NSLocalizedString("⭕️ Repository Name", comment: ""), for: .normal)
        searchInRepositoryName.contentHorizontalAlignment = .leading
        searchInRepositoryName.addTarget(self, action: #selector(SearchFilterViewController.toggleSearchInButton(sender:)), for: .touchUpInside)
        return searchInRepositoryName
    }()

    var searchInDescription: UIButton = {
        let searchInDescription = UIButton()
        searchInDescription.setTitleColor(UIColor.black, for: .normal)
        searchInDescription.setTitle(NSLocalizedString("⭕️ Description", comment: ""), for: .normal)
        searchInDescription.contentHorizontalAlignment = .leading
        searchInDescription.addTarget(self, action: #selector(SearchFilterViewController.toggleSearchInButton(sender:)), for: .touchUpInside)
        return searchInDescription
    }()

    var searchInReadme: UIButton = {
        let searchInReadme = UIButton()
        searchInReadme.setTitleColor(UIColor.black, for: .normal)
        searchInReadme.setTitle(NSLocalizedString("⭕️ Readme", comment: ""), for: .normal)
        searchInReadme.contentHorizontalAlignment = .leading
        searchInReadme.addTarget(self, action: #selector(SearchFilterViewController.toggleSearchInButton(sender:)), for: .touchUpInside)
        return searchInReadme
    }()

    // MARK: - Languages

    var languagesSelectionButton: UIButton = {
        let languagesSelectionButton = UIButton()
        languagesSelectionButton.setTitleColor(UIColor.black, for: .normal)
        languagesSelectionButton.setTitle(GitHubLanguage.allValues[0].rawValue, for: .normal)
        return languagesSelectionButton
    }()

    var languagesPicker: UIPickerView = {
        let languagesPicker = UIPickerView()
        return languagesPicker
    }()

    var languagesPickerManager: LanguagesPickerManager?

    var languagesPickerIsVisible = false

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

    var sizeRangeSelectionViewController: RangeSelectionViewController!

    var sizeRightTextfield: UITextField = {
        let sizeRightTextfield = UITextField()
        sizeRightTextfield.placeholder = NSLocalizedString("Size in KB", comment: "")
        sizeRightTextfield.keyboardType = .numberPad
        return sizeRightTextfield
    }()

    var sizeLeftTextfield: UITextField = {
        let sizeLeftTextfield = UITextField()
        sizeLeftTextfield.placeholder = NSLocalizedString("Size in KB", comment: "")
        sizeLeftTextfield.keyboardType = .numberPad
        return sizeLeftTextfield
    }()

    // MARK: - Number of stars

    var starsRangeSelectionViewController: RangeSelectionViewController!

    var starsRightTextfield: UITextField = {
        let starsRightTextfield = UITextField()
        starsRightTextfield.placeholder = NSLocalizedString("Number of stars", comment: "")
        starsRightTextfield.keyboardType = .numberPad
        return starsRightTextfield
    }()

    var starsLeftTextField: UITextField = {
        let starsLeftTextField = UITextField()
        starsLeftTextField.placeholder = NSLocalizedString("Number of stars", comment: "")
        starsLeftTextField.keyboardType = .numberPad
        return starsLeftTextField
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Disable All Filters", comment: "Reset filter button"), style: .plain, target: self, action: #selector(SearchFilterViewController.clearFilter))

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
        addChildViewController(numberOfForksRangeSelectionViewController)
        numberOfForksRangeSelectionViewController.rangeQualifierButton.addTarget(self, action: #selector(SearchFilterViewController.toggleRangeSelectionButton(sender:)), for: .touchUpInside)

        // languages

        languagesPickerManager = LanguagesPickerManager(button: languagesSelectionButton)
        languagesSelectionButton.addTarget(self, action: #selector(SearchFilterViewController.toggleLanguagesButton(sender:)), for: .touchUpInside)
        languagesPicker.dataSource = languagesPickerManager
        languagesPicker.delegate = languagesPickerManager

        // size

        sizeRangeSelectionViewController = RangeSelectionViewController(leftView: sizeLeftTextfield, rightView: sizeRightTextfield)
        addChildViewController(sizeRangeSelectionViewController)
        sizeRangeSelectionViewController.rangeQualifierButton.addTarget(self, action: #selector(SearchFilterViewController.toggleRangeSelectionButton(sender:)), for: .touchUpInside)

        // stars

        starsRangeSelectionViewController = RangeSelectionViewController(leftView: starsLeftTextField, rightView: starsRightTextfield)
        addChildViewController(starsRangeSelectionViewController)
        starsRangeSelectionViewController.rangeQualifierButton.addTarget(self, action: #selector(SearchFilterViewController.toggleRangeSelectionButton(sender:)), for: .touchUpInside)

        // text fields
        for textField in [numberOfForksLeftTextfield, numberOfForksRightTextfield, sizeLeftTextfield, sizeRightTextfield, starsLeftTextField, starsRightTextfield, orgOrUserTextField, topicsTextfield] {
            textField.inputAccessoryView = keyboardAccessoryView
        }

        setInitialCellsContents()
    }

}

extension SearchFilterViewController {

    @objc func dismissFilter() {
        willDismiss?(self)
        dismiss(animated: true)
    }

    @objc func clearFilter() {
        var indexPaths: [IndexPath] = []
        for section in 0..<sectionTitles.count {
            for row in 1..<cellContents[section].count {
                indexPaths.append(IndexPath(row: row, section: section))
            }
        }
        setInitialCellsContents()
        tableView.deleteRows(at: indexPaths, with: .top)
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

// MARK: - Button Action
extension SearchFilterViewController {

    @objc func toggleSearchInButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let oldTitle = sender.title(for: .normal) {
            let newTitle = (sender.isSelected ? "🔴" : "⭕️") + oldTitle.dropFirst()
            sender.setTitle(newTitle, for: .normal)
        }
    }

    @objc func toggleLanguagesButton(sender: UIButton) {
        let section = 4

        if languagesPickerIsVisible {
            let _ = cellContents[section].popLast()

            let indexPath = IndexPath(row: cellContents[section].count, section: section)
            tableView.deleteRows(at: [indexPath], with: .top)
        } else {
            cellContents[section].append(languagesPicker)
            let indexPath = IndexPath(row: cellContents[section].count-1, section: section)
            tableView.insertRows(at: [indexPath], with: .top)
        }
        languagesPickerIsVisible = !languagesPickerIsVisible
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

        // TODO: add method to get section and vc for sender
        switch sender {
        case numberOfForksRangeSelectionViewController.rangeQualifierButton:
            section = 2
            _rangeSelectionViewController = numberOfForksRangeSelectionViewController
        case sizeRangeSelectionViewController.rangeQualifierButton:
            section = 6
            _rangeSelectionViewController = sizeRangeSelectionViewController
        case starsRangeSelectionViewController.rangeQualifierButton:
            section = 7
            _rangeSelectionViewController = starsRangeSelectionViewController
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

// MARK: - fileprivate extension
fileprivate extension SearchFilterViewController {

    var cellContentInset: UIEdgeInsets {
        return UIEdgeInsetsMake(15, 15, 15, 15)
    }

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
             sizeRangeSelectionViewController.view],
            [viewForSection(title: sectionTitles[7]),
             starsRangeSelectionViewController.view],
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

    func setInitialCellsContents() {
        var initialCellContents: [[UIView]] = []

        for i in 0..<expandedCellContents.count {
            initialCellContents.append([viewForSection(title: sectionTitles[i])])
        }

        cellContents = initialCellContents
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

// MARK: - Keyboard
extension SearchFilterViewController {

    @objc func dismissKeyboard(sender: UIControl?) {
        view.endEditing(true)
    }

}
