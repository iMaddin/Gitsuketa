//
//  UIView+Layout.swift
//  Gitsuketa
//
//  Created by Maddin on 07.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

extension UIView {

    func constraints(equalToEdgeOf anotherView: UIView, constants: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) {
        anotherView.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: anotherView.topAnchor, constant: -constants.top).isActive = true
        self.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor, constant: constants.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: anotherView.leadingAnchor, constant: -constants.left).isActive = true
        self.trailingAnchor.constraint(equalTo: anotherView.trailingAnchor, constant: constants.right).isActive = true
    }

    func constraints(equalToEdgeOf layoutGuide: UILayoutGuide, constants: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) {
        self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: -constants.top).isActive = true
        self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: constants.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: -constants.left).isActive = true
        self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: constants.right).isActive = true
    }

}
