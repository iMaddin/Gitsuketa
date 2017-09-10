//
//  LanguagesPickerManager.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class LanguagesPickerManager: NSObject {

    let button: UIButton

    init(button: UIButton) {
        self.button = button
    }

}

// MARK: - UIPickerViewDataSource
extension LanguagesPickerManager: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GitHubLanguage.allValues.count
    }

}

// MARK: - UIPickerViewDelegate
extension LanguagesPickerManager: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GitHubLanguage.allValues[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        button.setTitle(GitHubLanguage.allValues[row].rawValue, for: .normal)
    }

}
