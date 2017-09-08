//
//  GitHubRangeValue.swift
//  Gitsuketa
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

protocol GitHubRangeValueProtocol {
    associatedtype T

    var value: T { get }
    var rangeQualifier: GitHubRangeQualifier { get }
    var fromValue: T? { get }

}

extension GitHubRangeValueProtocol where T == Int {

    var stringQualifier: String {
        let stringQualifier: String
        if let fromValue = fromValue, rangeQualifier == .between {
            stringQualifier = String(fromValue) + rangeQualifier.description() + String(value)
        } else {
            stringQualifier = rangeQualifier.description() + String(value)
        }
        return stringQualifier
    }

}

extension GitHubRangeValueProtocol where T == Date {

    var stringQualifier: String {
        let stringQualifier: String
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate] // Not using .withInternetDateTime because the time zone is only shown as "Z" possibly due to a bug

        if let fromValue = fromValue, rangeQualifier == .between {
            stringQualifier = formatter.string(from: fromValue) + rangeQualifier.description() + formatter.string(from: value)
        } else {
            stringQualifier = rangeQualifier.description() + formatter.string(from: value)
        }
        return stringQualifier
    }

}

struct GitHubRangeValue<T>: GitHubRangeValueProtocol {

    let value: T
    let rangeQualifier: GitHubRangeQualifier
    let fromValue: T?

}

extension GitHubRangeValue {

    init(value: T, rangeQualifier: GitHubRangeQualifier) {
        assert(rangeQualifier != .between)
        self.value = value
        self.rangeQualifier = rangeQualifier
        self.fromValue = nil
    }

    init(value: T, fromValue: T?) {
        rangeQualifier = .between
        self.value = value
        self.fromValue = fromValue
    }

}
