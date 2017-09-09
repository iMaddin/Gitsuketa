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
            if let title = viewModel?.title {
                titleLabel.text = title
                contentStackView.addArrangedSubview(titleLabel)
            }
            
            if let description = viewModel?.description {
                descriptionLabel.text = description
                contentStackView.addArrangedSubview(descriptionLabel)
            }

            if let formatedUpdatedAt = viewModel?.formatedUpdatedAt {
                formatedUpdatedAtLabel.text = formatedUpdatedAt
                contentStackView.addArrangedSubview(formatedUpdatedAtLabel)
            }

//            if let url = viewModel?.url {
//                urlLabel.text = url
//                contentStackView.addArrangedSubview(urlLabel)
//            }
//
            if let formattedLanguage = viewModel?.formattedLanguage {
                formattedLanguageLabel.text = formattedLanguage
                contentStackView.addArrangedSubview(formattedLanguageLabel)
            }
            
            if let stars = viewModel?.stars {
                starsLabel.text = "⭐️\(stars)"
                contentStackView.addArrangedSubview(starsLabel)
            }
            
            if let hasReadme = viewModel?.hasReadme ,
                hasReadme == true {
                hasReadmeLabel.text = "readme"
                contentStackView.addArrangedSubview(hasReadmeLabel)
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

    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in contentStackView.arrangedSubviews {
            contentStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

}

fileprivate extension SearchResultsViewCell {

    func _commonInit() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical

        contentView.addSubview(contentStackView)
        contentView.constraints(equalToEdgeOf: contentStackView)
    }

}
