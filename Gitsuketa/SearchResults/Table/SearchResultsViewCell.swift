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
            if let title = viewModel?.title,
                let titleLabel = self.titleLabel {
                titleLabel.text = title
                contentStackView.addArrangedSubview(titleLabel)
            }
            
            if let description = viewModel?.description,
                let descriptionLabel = self.descriptionLabel {
                descriptionLabel.text = description
                contentStackView.addArrangedSubview(descriptionLabel)
            }

            if let formatedUpdatedAt = viewModel?.formatedUpdatedAt,
                let formatedUpdatedAtLabel = self.formatedUpdatedAtLabel {
                formatedUpdatedAtLabel.text = formatedUpdatedAt
                contentStackView.addArrangedSubview(formatedUpdatedAtLabel)
            }

//            if let url = viewModel?.url,
//                let urlLabel = self.urlLabel {
//                urlLabel.text = url
//                contentStackView.addArrangedSubview(urlLabel)
//            }
//
            if let formattedLanguage = viewModel?.formattedLanguage,
                let formattedLanguageLabel = self.formattedLanguageLabel {
                formattedLanguageLabel.text = formattedLanguage
                contentStackView.addArrangedSubview(formattedLanguageLabel)
            }
            
            if let stars = viewModel?.stars,
                let starsLabel = self.starsLabel {
                starsLabel.text = "⭐️\(stars)"
                contentStackView.addArrangedSubview(starsLabel)
            }
            
            if let hasReadme = viewModel?.hasReadme,
                let hasReadmeLabel = self.hasReadmeLabel,
                hasReadme == true {
                hasReadmeLabel.text = "readme"
                contentStackView.addArrangedSubview(hasReadmeLabel)
            }
            
        }
    }

    lazy var titleLabel: UILabel? = {
        let titleLabel = UILabel()
        return titleLabel
    }()

    lazy var descriptionLabel: UILabel? = {
        let descriptionLabel = UILabel()
        return descriptionLabel
    }()

    lazy var urlLabel: UILabel? = {
        let urlLabel = UILabel()
        return urlLabel
    }()

    lazy var formattedLanguageLabel: UILabel? = {
        let formattedLanguageLabel = UILabel()
        return formattedLanguageLabel
    }()

    lazy var formatedUpdatedAtLabel: UILabel? = {
        let formatedUpdatedAtLabel = UILabel()
        return formatedUpdatedAtLabel
    }()

    lazy var starsLabel: UILabel? = {
        let starsLabel = UILabel()
        return starsLabel
    }()

    lazy var hasReadmeLabel: UILabel? = {
        let hasReadmeLabel = UILabel()
        return hasReadmeLabel
    }()

    var cellHorizontalSpacing: CGFloat = 15
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

}

fileprivate extension SearchResultsViewCell {

    func _commonInit() {
        let containerView = UIView()
        containerView.accessibilityIdentifier = "containerView"
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 4
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor

        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellHorizontalSpacing).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellHorizontalSpacing).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical

        containerView.addSubview(contentStackView)
        contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: cellHorizontalSpacing).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -cellHorizontalSpacing).isActive = true
        contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: cellHorizontalSpacing).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -cellHorizontalSpacing).isActive = true
    }

}
