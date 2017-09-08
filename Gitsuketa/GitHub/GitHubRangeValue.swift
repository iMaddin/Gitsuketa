//
//  GitHubRangeValue.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct GitHubRangeValue<T> {

    let value: T
    let rangeQualifier: GitHubRangeQualifier
    let optionalValue: T?

}

extension GitHubRangeValue {

    init(value: T, rangeQualifier: GitHubRangeQualifier) {
        self.value = value
        self.rangeQualifier = rangeQualifier
        self.optionalValue = nil
        assert(rangeQualifier != .between)
    }

    init(value: T, optionalValue: T?) {
        rangeQualifier = .between
        self.value = value
        self.optionalValue = optionalValue
    }

}

extension GitHubRangeValue where T == Int {

    var stringQualifier: String {
        let stringQualifier: String
        if let optionalValue = optionalValue, rangeQualifier == .between {
            stringQualifier = String(optionalValue) + rangeQualifier.description() + String(value)
        } else {
            stringQualifier = rangeQualifier.description() + String(value)
        }
        return stringQualifier
    }

}
