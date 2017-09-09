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
        }
        get {
            return super.isSelected
        }
    }

    func foo() {

    }
}
