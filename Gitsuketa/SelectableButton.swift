//
//  UIButton+SelectedState.swift
//  Gitsuketa
//
//  Created by Maddin on 09.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SelectableButton: UIButton {

    override var isSelected: Bool {
        set {
            super.isSelected = newValue
            enableSelectedStyling(flag: isSelected)
        }
        get {
            return super.isSelected
        }
    }

}

fileprivate extension SelectableButton {

    func enableSelectedStyling(flag: Bool) {
        layer.backgroundColor = isSelected ? titleColor(for: .normal)?.cgColor : titleColor(for: .selected)?.cgColor
    }

}
