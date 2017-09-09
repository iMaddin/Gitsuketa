//
//  SearchResultsTableViewCell.swift
//  Gitsuketa
//
//  Created by Maddin on 06.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchResultsViewCell: UICollectionViewCell {

    var viewModel: GitHubSearchResultItem? {
        didSet {
            var text: String?

            for v in allAxisViews {
                switch v {
                case titleLabel:
                    text = viewModel?.fullName
                case descriptionLabel:
                    text = viewModel?.descriptionText
                case urlLabel:
                    text = viewModel?.url
                case formattedLanguageLabel:
                    text = viewModel?.language
                case formatedUpdatedAtLabel:
                    if let updatedAt = viewModel?.updatedAt, let date = ISO8601DateFormatter().date(from: updatedAt) {
                        text = dateFormatter.string(from: date)
                    }
                case starsLabel:
                    if let stars = viewModel?.stargazersCount {
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
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        return titleLabel
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        return descriptionLabel
    }()

    var urlLabel: UILabel = {
        let urlLabel = UILabel()
        urlLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        urlLabel.adjustsFontForContentSizeCategory = true
        return urlLabel
    }()

    var formattedLanguageLabel: UILabel = {
        let formattedLanguageLabel = UILabel()
        formattedLanguageLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        formattedLanguageLabel.adjustsFontForContentSizeCategory = true
        return formattedLanguageLabel
    }()

    var formatedUpdatedAtLabel: UILabel = {
        let formatedUpdatedAtLabel = UILabel()
        formatedUpdatedAtLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        formatedUpdatedAtLabel.adjustsFontForContentSizeCategory = true
        return formatedUpdatedAtLabel
    }()

    var starsLabel: UILabel = {
        let starsLabel = UILabel()
        starsLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        starsLabel.adjustsFontForContentSizeCategory = true
        return starsLabel
    }()

    var hasReadmeLabel: UILabel = {
        let hasReadmeLabel = UILabel()
        hasReadmeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasReadmeLabel.adjustsFontForContentSizeCategory = true
        return hasReadmeLabel
    }()

    let contentStackView = UIStackView()

    fileprivate var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

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
        height = height + contentInsetSpacing * 2
        height = height + CGFloat((allAxisViews.count-1)) * contentStackView.spacing
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
//            urlLabel,
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
        contentStackView.spacing = 4

        contentView.addSubview(contentStackView)
        contentView.constraints(equalToEdgeOf: contentStackView, constants: UIEdgeInsetsMake(contentInsetSpacing, contentInsetSpacing, contentInsetSpacing, contentInsetSpacing))
    }

}
