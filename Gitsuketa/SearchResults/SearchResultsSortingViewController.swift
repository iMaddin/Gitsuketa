//
//  ResultSortingViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 09.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchResultsSortingViewController: UIViewController {

    var height: CGFloat = 44 {
        didSet {
            heightConstraint?.constant = height
        }
    }

    fileprivate var heightConstraint: NSLayoutConstraint?

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()

    var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
        view.backgroundColor = UIColor.green
    }

}
