//
//  SearchResultsTableViewCell.swift
//  Gitsuketa
//
//  Created by Maddin on 06.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchResultsViewCell: UICollectionViewCell {

    var viewModel: SearchResultItem? {
        didSet {
            var text: String?

            for v in allAxisViews {
                switch v {
                case titleLabel:
                    text = viewModel?.title
                case descriptionLabel:
                    text = viewModel?.description
                case urlLabel:
                    text = viewModel?.url
                case formattedLanguageLabel:
                    text = viewModel?.formattedLanguage
                case formatedUpdatedAtLabel:
                    text = viewModel?.formatedUpdatedAt
                case starsLabel:
                    if let stars = viewModel?.stars {
                        text = "⭐️\(stars)"
                    }
                case hasReadmeLabel:
                    if let hasReadme = viewModel?.hasReadme {
                        text = hasReadme ? "readme ✅" : "readme ❌"
                    } else {
                        text = "readme 🤷🏻‍♂️"
                    }
                default:
                    text = nil
                }

                if let t = text {
                    v.text = t
                    contentStackView.addArrangedSubview(v)
                } else {
                    contentStackView.removeArrangedSubview(v)
                    v.removeFromSuperview()
                }

            }
        }
    }

    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        return descriptionLabel
    }()

    var urlLabel: UILabel = {
        let urlLabel = UILabel()
        return urlLabel
    }()

    var formattedLanguageLabel: UILabel = {
        let formattedLanguageLabel = UILabel()
        return formattedLanguageLabel
    }()

    var formatedUpdatedAtLabel: UILabel = {
        let formatedUpdatedAtLabel = UILabel()
        return formatedUpdatedAtLabel
    }()

    var starsLabel: UILabel = {
        let starsLabel = UILabel()
        return starsLabel
    }()

    var hasReadmeLabel: UILabel = {
        let hasReadmeLabel = UILabel()
        return hasReadmeLabel
    }()

    let contentStackView = UIStackView()

    init() {
        super.init(frame: CGRect.zero)
        _commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in contentStackView.arrangedSubviews {
            contentStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    var intrinsicContentHeight: CGFloat {
        var height: CGFloat = 0
        for v in contentStackView.arrangedSubviews {
            height = height + v.intrinsicContentSize.height
        }
        height = height + contentInsetSpacing*2
        return height
    }

}

fileprivate extension SearchResultsViewCell {

    var contentInsetSpacing: CGFloat {
        return 15
    }

    var allAxisViews: [UILabel] {
        return [
            titleLabel,
            descriptionLabel,
            urlLabel,
            formattedLanguageLabel,
            formatedUpdatedAtLabel,
            starsLabel,
            hasReadmeLabel
        ]
    }

    func _commonInit() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical

        contentView.addSubview(contentStackView)
        contentView.constraints(equalToEdgeOf: contentStackView, constants: UIEdgeInsetsMake(contentInsetSpacing, contentInsetSpacing, contentInsetSpacing, contentInsetSpacing))
    }

}
