//
//  RangeSelectionViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class RangeSelectionViewController: UIViewController {

    // MARK: - Properties

    var pickerViewIsVisible = false

    fileprivate var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()

    var rangeQualifierButton: UIButton = {
        let rangeQualifierButton = UIButton()
        rangeQualifierButton.setTitle(NSLocalizedString("=", comment: "Select Date placeholder text"), for: .normal)
        return rangeQualifierButton
    }()

    var rangeQualifierPickerView: UIPickerView = {
        let rangeQualifierPickerView = UIPickerView()
        rangeQualifierPickerView.accessibilityIdentifier = " dateRange SegmentedControl"
        return rangeQualifierPickerView
    }()

    var rangeQualifierPickerManager: RangeQualifierPickerManager?

    // MARK: - RangeSelectionViewController

    let leftView: UIView
    let rightView: UIView

    init(leftView: UIView, rightView: UIView) {
        self.leftView = leftView
        self.rightView = rightView
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - UIViewController

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackView)
        view.constraints(equalToEdgeOf: stackView)

        stackView.addArrangedSubview(rangeQualifierButton)
        stackView.addArrangedSubview(rightView)

        rangeQualifierPickerManager = RangeQualifierPickerManager(button: rangeQualifierButton)
        rangeQualifierPickerManager?.didSelectBetweenRangeQualifier = { flag in self.didSelectBetweenRangeQualifier(flag: flag)}

        rangeQualifierPickerView.dataSource = rangeQualifierPickerManager
        rangeQualifierPickerView.delegate = rangeQualifierPickerManager

        rangeQualifierButton.setTitleColor(view.tintColor, for: .normal)
    }

}

// MARK: - fileprivate
fileprivate extension RangeSelectionViewController {

    func didSelectBetweenRangeQualifier(flag: Bool) {
        if flag {
            stackView.insertArrangedSubview(leftView, at: 0)
        } else {
            leftView.removeFromSuperview()
            stackView.removeArrangedSubview(leftView)
        }
    }

}
