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

    var viewOptions: DataViewOptionsManager {
        didSet {
            
        }
    }

    // MARK: - Labels

    lazy var createdAtLabel: UILabel = {
        let createdAtLabel = UILabel()
        createdAtLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        createdAtLabel.adjustsFontForContentSizeCategory = true
        return createdAtLabel
    }()

    lazy var defaultBranchLabel: UILabel = {
        let defaultBranchLabel = UILabel()
        defaultBranchLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        defaultBranchLabel.adjustsFontForContentSizeCategory = true
        return defaultBranchLabel
    }()

    lazy var descriptionTextLabel: UILabel = {
        let descriptionTextLabel = UILabel()
        descriptionTextLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionTextLabel.adjustsFontForContentSizeCategory = true
        return descriptionTextLabel
    }()

    lazy var forkLabel: UILabel = {
        let forkLabel = UILabel()
        forkLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        forkLabel.adjustsFontForContentSizeCategory = true
        return forkLabel
    }()

    lazy var forksLabel: UILabel = {
        let forksLabel = UILabel()
        forksLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        forksLabel.adjustsFontForContentSizeCategory = true
        return forksLabel
    }()

    lazy var forksCountLabel: UILabel = {
        let forksCountLabel = UILabel()
        forksCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        forksCountLabel.adjustsFontForContentSizeCategory = true
        return forksCountLabel
    }()

    lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        fullNameLabel.adjustsFontForContentSizeCategory = true
        return fullNameLabel
    }()

    lazy var hasDownloadsLabel: UILabel = {
        let hasDownloadsLabel = UILabel()
        hasDownloadsLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasDownloadsLabel.adjustsFontForContentSizeCategory = true
        return hasDownloadsLabel
    }()

    lazy var hasIssuesLabel: UILabel = {
        let hasIssuesLabel = UILabel()
        hasIssuesLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasIssuesLabel.adjustsFontForContentSizeCategory = true
        return hasIssuesLabel
    }()

    lazy var hasPagesLabel: UILabel = {
        let hasPagesLabel = UILabel()
        hasPagesLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasPagesLabel.adjustsFontForContentSizeCategory = true
        return hasPagesLabel
    }()

    lazy var hasProjectsLabel: UILabel = {
        let hasProjectsLabel = UILabel()
        hasProjectsLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasProjectsLabel.adjustsFontForContentSizeCategory = true
        return hasProjectsLabel
    }()

    lazy var hasReadmeLabel: UILabel = {
        let hasReadmeLabel = UILabel()
        hasReadmeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasReadmeLabel.adjustsFontForContentSizeCategory = true
        return hasReadmeLabel
    }()

    lazy var hasWikiLabel: UILabel = {
        let hasWikiLabel = UILabel()
        hasWikiLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        hasWikiLabel.adjustsFontForContentSizeCategory = true
        return hasWikiLabel
    }()

    lazy var languageLabel: UILabel = {
        let languageLabel = UILabel()
        languageLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        languageLabel.adjustsFontForContentSizeCategory = true
        return languageLabel
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        nameLabel.adjustsFontForContentSizeCategory = true
        return nameLabel
    }()

    lazy var openIssuesLabel: UILabel = {
        let openIssuesLabel = UILabel()
        openIssuesLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        openIssuesLabel.adjustsFontForContentSizeCategory = true
        return openIssuesLabel
    }()

    lazy var openIssuesCountLabel: UILabel = {
        let openIssuesCountLabel = UILabel()
        openIssuesCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        openIssuesCountLabel.adjustsFontForContentSizeCategory = true
        return openIssuesCountLabel
    }()

    lazy var ownerLabel: UILabel = {
        let ownerLabel = UILabel()
        ownerLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        ownerLabel.adjustsFontForContentSizeCategory = true
        return ownerLabel
    }()

    lazy var isPrivateLabel: UILabel = {
        let isPrivateLabel = UILabel()
        isPrivateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        isPrivateLabel.adjustsFontForContentSizeCategory = true
        return isPrivateLabel
    }()

    lazy var pushedAtLabel: UILabel = {
        let pushedAtLabel = UILabel()
        pushedAtLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        pushedAtLabel.adjustsFontForContentSizeCategory = true
        return pushedAtLabel
    }()

    lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        scoreLabel.adjustsFontForContentSizeCategory = true
        return scoreLabel
    }()

    lazy var sizeLabel: UILabel = {
        let sizeLabel = UILabel()
        sizeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        sizeLabel.adjustsFontForContentSizeCategory = true
        return sizeLabel
    }()

    lazy var stargazersCountLabel: UILabel = {
        let stargazersCountLabel = UILabel()
        stargazersCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        stargazersCountLabel.adjustsFontForContentSizeCategory = true
        return stargazersCountLabel
    }()

    lazy var updatedAtLabel: UILabel = {
        let updatedAtLabel = UILabel()
        updatedAtLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        updatedAtLabel.adjustsFontForContentSizeCategory = true
        return updatedAtLabel
    }()

    lazy var urlLabel: UILabel = {
        let urlLabel = UILabel()
        urlLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        urlLabel.adjustsFontForContentSizeCategory = true
        return urlLabel
    }()

    lazy var watchersLabel: UILabel = {
        let watchersLabel = UILabel()
        watchersLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        watchersLabel.adjustsFontForContentSizeCategory = true
        return watchersLabel
    }()

    lazy var watchersCountLabel: UILabel = {
        let watchersCountLabel = UILabel()
        watchersCountLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        watchersCountLabel.adjustsFontForContentSizeCategory = true
        return watchersCountLabel
    }()

    fileprivate var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.accessibilityIdentifier = "cell.contentStackView"
        contentStackView.axis = .vertical
        contentStackView.spacing = 4
        return contentStackView
    }()

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
        height = height + CGFloat((contentStackView.arrangedSubviews.count-1)) * contentStackView.spacing
        return height
    }

}

fileprivate extension SearchResultsViewCell {

    var contentInsetSpacing: CGFloat {
        return 15
    }

    func _commonInit() {
        contentView.addSubview(contentStackView)
        contentView.constraints(equalToEdgeOf: contentStackView, constants: UIEdgeInsetsMake(contentInsetSpacing, contentInsetSpacing, contentInsetSpacing, contentInsetSpacing))
    }

    func formatDate(fromString stringDate: String?) -> String? {
        if let stringDate = stringDate, let date = ISO8601DateFormatter().date(from: stringDate) {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}

fileprivate extension SearchResultsViewCell {

    func label(forDataViewOption option: DataViewOptions) -> UILabel {
        switch option {
        case .createdAt:
            return createdAtLabel
        case .defaultBranch:
            return defaultBranchLabel
        case .descriptionText:
            return descriptionTextLabel
        case .fork:
            return forkLabel
        case .forks:
            return forksLabel
        case .forksCount:
            return forksCountLabel
        case .fullName:
            return fullNameLabel
        case .hasDownloads:
            return hasDownloadsLabel
        case .hasIssues:
            return hasIssuesLabel
        case .hasPages:
            return hasPagesLabel
        case .hasProjects:
            return hasProjectsLabel
        case .hasReadme:
            return hasReadmeLabel
        case .hasWiki:
            return hasWikiLabel
        case .language:
            return languageLabel
        case .name:
            return nameLabel
        case .openIssues:
            return openIssuesLabel
        case .openIssuesCount:
            return openIssuesCountLabel
        case .owner:
            return ownerLabel
        case .isPrivate:
            return isPrivateLabel
        case .pushedAt:
            return pushedAtLabel
        case .score:
            return scoreLabel
        case .size:
            return sizeLabel
        case .stargazersCount:
            return stargazersCountLabel
        case .updatedAt:
            return updatedAtLabel
        case .url:
            return urlLabel
        case .watchers:
            return watchersLabel
        case .watchersCount:
            return watchersCountLabel
        }
    }

    func text(forDataViewOption option: DataViewOptions) -> String? {
        switch option {
        case .createdAt:
            return viewModel?.createdAt
        case .defaultBranch:
            return viewModel?.defaultBranch
        case .descriptionText:
            return viewModel?.descriptionText
        case .fork:
            if let fork = viewModel?.fork {
                return option.description + "\(fork)"
            } else {
                return nil
            }
        case .forks:
            if let forks = viewModel?.forks {
                return "forks \(forks)"
            } else {
                return nil
            }
        case .forksCount:
            if let forksCount = viewModel?.forksCount {
                return option.description + "\(forksCount)"
            } else {
                return nil
            }
        case .fullName:
            return viewModel?.fullName
        case .hasDownloads:
            if let hasDownloads = viewModel?.hasDownloads {
                return option.description + "\(hasDownloads)"
            } else {
                return nil
            }
        case .hasIssues:
            if let hasIssues = viewModel?.hasIssues {
                return option.description + "\(hasIssues)"
            } else {
                return nil
            }
        case .hasPages:
            if let hasPages = viewModel?.hasPages {
                return option.description + "\(hasPages)"
            } else {
                return nil
            }
        case .hasProjects:
            if let hasProjects = viewModel?.hasProjects {
                return option.description + "\(hasProjects)"
            } else {
                return nil
            }
        case .hasReadme:
            if let hasReadme = viewModel?.hasReadme {
                return option.description + "\(hasReadme)"
            } else {
                return nil
            }
        case .hasWiki:
            if let hasWiki = viewModel?.hasWiki {
                return option.description + "\(hasWiki)"
            } else {
                return nil
            }
        case .language:
            return viewModel?.language
        case .name:
            return viewModel?.name
        case .openIssues:
            if let openIssues = viewModel?.openIssues {
                return option.description + "\(openIssues)"
            } else {
                return nil
            }
        case .openIssuesCount:
            if let openIssuesCount = viewModel?.openIssuesCount {
                return option.description + "\(openIssuesCount)"
            } else {
                return nil
            }
        case .owner:
            if let owner = viewModel?.owner {
                return option.description + "\(owner)"
            } else {
                return nil
            }
        case .isPrivate:
            if let isPrivate = viewModel?.isPrivate {
                return option.description + "\(isPrivate)"
            } else {
                return nil
            }
        case .pushedAt:
            return viewModel?.pushedAt
        case .score:
            if let score = viewModel?.score {
                return option.description + "\(score)"
            } else {
                return nil
            }
        case .size:
            if let size = viewModel?.size {
                return option.description + "\(size)"
            } else {
                return nil
            }
        case .stargazersCount:
            if let stargazersCount = viewModel?.stargazersCount {
                return option.description + "\(stargazersCount)"
            } else {
                return nil
            }
        case .updatedAt:
            return viewModel?.updatedAt
        case .url:
            return viewModel?.url
        case .watchers:
            if let watchers = viewModel?.watchers {
                return option.description + "\(watchers)"
            } else {
                return nil
            }
        case .watchersCount:
            if let watchersCount = viewModel?.watchersCount {
                return option.description + "\(watchersCount)"
            } else {
                return nil
            }
        }
    }

}
