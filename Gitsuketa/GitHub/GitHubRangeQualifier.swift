//
//  GitHubRangeQualifier.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

enum GitHubRangeQualifier: String {

    case equal = ""
    case moreThan = ">"
    case greaterOrEqual = ">="
    case lessThan = "<"
    case lessOrEqual = "<="
    case between = ".."

    func description() -> String {
        switch (self) {
        case .equal:
            return "="
        default:
            return self.rawValue
        }
    }

    static var allQualifiers: [GitHubRangeQualifier] {
        return [
            .equal,
			.moreThan,
			.greaterOrEqual,
			.lessThan,
			.lessOrEqual,
			.between
        ]
    }

    static var allQualifierDescriptions: [String] {
        return allQualifiers.map{$0.description()}
    }

}
