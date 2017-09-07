//
//  SearchFilterViewController.swift
//  Gitsuketa
//
//  Created by Maddin on 07.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

class SearchFilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done button for dismissing modal view"), style: .done, target: self, action: #selector(SearchFilterViewController.dismissFilter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Reset filter", comment: "Reset filter button"), style: .plain, target: self, action: #selector(SearchFilterViewController.clearFilter))
    }

}

extension SearchFilterViewController {

    @objc func dismissFilter() {
        dismiss(animated: true)
    }

    @objc func clearFilter() {

    }
    
}
