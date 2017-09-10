//
//  ResultSortingViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 09.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

protocol SearchResultsSortingDelegate {
    func searchResultsSortingViewController(_ searchResultsSortingViewController: SearchResultsSortingViewController, didSelectSortingOption sortingOption: GitHubSortingOption)
}

class SearchResultsSortingViewController: UIViewController {

    var delegate: SearchResultsSortingDelegate?

    var height: CGFloat = 44 {
        didSet {
            heightConstraint?.constant = height
        }
    }

    var selectedSortingIndex: Int = 0 {
        didSet {
            setDefaultSelectedButton(index: selectedSortingIndex)
        }
    }

    fileprivate var heightConstraint: NSLayoutConstraint?

    fileprivate var currentlySelectedButton: UIButton!

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true

        let bottomSeparatorView = UIView()
        bottomSeparatorView.layer.backgroundColor = UIColor.gray.cgColor
        view.addSubview(bottomSeparatorView)
        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        bottomSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomSeparatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollView.contentInset = UIEdgeInsetsMake(0, spacing, 0, spacing)
        scrollView.showsHorizontalScrollIndicator = false

        view.addSubview(scrollView)
        view.constraints(equalToEdgeOf: scrollView)
        scrollView.addSubview(stackView)
        scrollView.constraints(equalToEdgeOf: stackView)
        scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1).isActive = true

        for sortingOption in GitHubSortingOption.allValues {
            let sortingButton = SelectableButton()
            sortingButton.style = {
                button in
                button.layer.cornerRadius = button.intrinsicContentSize.height/2
                button.layer.borderColor = button.isSelected ? button.titleColor(for: .selected)?.cgColor : button.titleColor(for: .normal)?.cgColor
                button.layer.borderWidth = button.isSelected ? 1 : 0
            }
            sortingButton.setTitle(sortingOption.description, for: .normal)
            sortingButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
            sortingButton.setTitleColor(UIColor.gray, for: .normal)
            sortingButton.setTitleColor(self.view.tintColor, for: .selected)
            sortingButton.addTarget(self, action: #selector(sortingButtonPressed(sender:)), for: .touchUpInside)
            sortingButton.widthAnchor.constraint(equalToConstant: sortingButton.intrinsicContentSize.width+20).isActive = true
            stackView.addArrangedSubview(sortingButton)
        }

        setDefaultSelectedButton(index: selectedSortingIndex)
    }

}

fileprivate extension SearchResultsSortingViewController {

    var spacing: CGFloat {
        return 10
    }

}

// MARK: - Button Action
fileprivate extension SearchResultsSortingViewController {

    @objc func sortingButtonPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let currentlySelectedButton = currentlySelectedButton {
            currentlySelectedButton.isSelected = !currentlySelectedButton.isSelected
        }
        currentlySelectedButton = sender

        guard let senderIndex = stackView.arrangedSubviews.index(of: sender) else {
            assertionFailure()
            return
        }
        let selectedSortingOption = GitHubSortingOption.allValues[senderIndex]
        delegate?.searchResultsSortingViewController(self, didSelectSortingOption: selectedSortingOption)
    }

    func setDefaultSelectedButton(index: Int) {
        if let buttonToSelect = stackView.arrangedSubviews[index] as? UIButton {
            sortingButtonPressed(sender: buttonToSelect)
        }
    }

}
