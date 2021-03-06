//
//  RangeQualifierPickerManager.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class RangeQualifierPickerManager: NSObject {

    let button: UIButton

    var didSelectBetweenRangeQualifier: ((_ flag: Bool) -> Void)?

    init(button: UIButton) {
        self.button = button
    }

}

// MARK: - UIPickerViewDataSource
extension RangeQualifierPickerManager: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GitHubRangeQualifier.allValues.count
    }

}

// MARK: - UIPickerViewDelegate
extension RangeQualifierPickerManager: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GitHubRangeQualifier.allQualifierDescriptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        button.setTitle(GitHubRangeQualifier.allQualifierDescriptions[row], for: .normal)
        didSelectBetweenRangeQualifier?(row >= GitHubRangeQualifier.allQualifierDescriptions.count - 1)
    }

}
