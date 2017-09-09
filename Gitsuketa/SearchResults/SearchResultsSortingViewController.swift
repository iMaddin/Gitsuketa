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

        stackView.spacing = spacing
        scrollView.contentInset = UIEdgeInsetsMake(0, spacing, 0, spacing)
        scrollView.showsHorizontalScrollIndicator = false

        view.addSubview(scrollView)
        view.constraints(equalToEdgeOf: scrollView)
        scrollView.addSubview(stackView)
        scrollView.constraints(equalToEdgeOf: stackView)
        scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1).isActive = true

        for sortingOption in GitHubSortingOption.allValues {
            let sortingButton = SelectableButton()
            sortingButton.setTitle(sortingOption.description, for: .normal)
            sortingButton.setTitleColor(UIColor.blue, for: .normal)
            stackView.addArrangedSubview(sortingButton)
        }
    }

}

fileprivate extension SearchResultsSortingViewController {

    var spacing: CGFloat {
        return 15
    }

}
