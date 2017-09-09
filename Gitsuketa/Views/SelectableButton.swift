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
        layer.cornerRadius = intrinsicContentSize.height/2
        layer.borderColor = isSelected ? titleColor(for: .selected)?.cgColor : titleColor(for: .normal)?.cgColor
        layer.borderWidth = isSelected ? 1 : 0
    }

}
