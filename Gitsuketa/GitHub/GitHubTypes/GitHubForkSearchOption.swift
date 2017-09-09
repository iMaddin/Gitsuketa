//
//  GitHubForkSearchOption.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

enum GitHubForkSearchOption: String {

    case includeForks = "true", onlyForks = "only"

    func description() -> String {
        switch self {
        case .includeForks:
            return "include forks"
        case .onlyForks:
            return "only forks"
        }
    }

    static var allValues: [GitHubForkSearchOption] {
        return [.includeForks, .onlyForks]
    }

}
