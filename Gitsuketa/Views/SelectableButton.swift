//
//  UIButton+SelectedState.swift
//  Gitsuketa
//
//  Created by Maddin on 09.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SelectableButton: UIButton {

    var style: ((_ button: SelectableButton) -> Void)?

    override var isSelected: Bool {
        set {
            super.isSelected = newValue
            style?(self)
        }
        get {
            return super.isSelected
        }
    }

}
