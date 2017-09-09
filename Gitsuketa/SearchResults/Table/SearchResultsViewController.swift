//
//  SearchResultsViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchResultsViewController: UICollectionViewController {

    var searchResults: SearchResultsFormatting?
    var cellVerticalSpacing: CGFloat = 20
    var didSelectRowAction: ((String?) -> Void)?

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(SearchResultsViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.isPrefetchingEnabled = false
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: 0)
    }

}

// MARK: - UICollectionViewDataSource
extension SearchResultsViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 4
        cell.layer.borderWidth = 0.5

        if let searchResultsViewCell = cell  as? SearchResultsViewCell {
            searchResultsViewCell.viewModel = searchResults?.items[indexPath.section]
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension SearchResultsViewController {

    override func collectionView(_: UICollectionView, didSelectItemAt: IndexPath) {
        didSelectRowAction?(searchResults?.items[didSelectItemAt.row].url)
    }

}

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat

        if let cell = collectionView.cellForItem(at: indexPath) {
            height = cell.intrinsicContentSize.height
        } else {
            height = 200
        }

        let width = collectionView.frame.width - spacing*2
        return CGSize(width: width, height: height)
    }

}

fileprivate extension SearchResultsViewController {

    var cellIdentifier: String {
        return "CellIdentifier"
    }

    var spacing: CGFloat {
        return 15
    }

}
