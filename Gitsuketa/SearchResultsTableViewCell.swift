//
//  SearchResultsTableViewCell.swift
//  Gitsuketa
//
//  Created by Maddin on 06.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    let titleLabel: UILabel
    let descriptionLabel: UILabel
    let languageLabel: UILabel
    let updatedAtLabel: UILabel
    let starsLabel: UILabel
    let hasReadmeLabel: UILabel

    var cellHorizontalSpacing: CGFloat = 15

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        let titleLabel = UILabel()
        self.titleLabel = titleLabel

        let descriptionLabel = UILabel()
        self.descriptionLabel = descriptionLabel

        let languageLabel = UILabel()
        self.languageLabel = languageLabel
        
        let updatedAtLabel = UILabel()
        self.updatedAtLabel = updatedAtLabel
        
        let starsLabel = UILabel()
        self.starsLabel = starsLabel
        
        let hasReadmeLabel = UILabel()
        self.hasReadmeLabel = hasReadmeLabel
        

        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical

        containerView.addSubview(contentStackView)
        contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: cellHorizontalSpacing).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -cellHorizontalSpacing).isActive = true
        contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: cellHorizontalSpacing).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -cellHorizontalSpacing).isActive = true

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
