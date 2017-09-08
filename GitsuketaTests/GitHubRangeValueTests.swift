//
//  GitHubRangeValueTests.swift
//  GitsuketaTests
//
//  Created by Maddin on 08.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import XCTest
@testable import Gitsuketa

class GitHubRangeValueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension GitHubRangeValueTests {

    func testBetweenIntStringQualifier() {
        let between = GitHubRangeValue(value: 4, fromValue: 0)
        XCTAssertEqual(between.stringQualifier, "0..4")
    }

}

extension GitHubRangeValueTests {

    func testBetweenDateWithoutTimeStringQualifier() {
        let fromDate = "2017-07-04T00:00:00+00:00"
        let toDate = "2017-12-13T00:00:00+00:00"
        let between = GitHubRangeValue(value: ISO8601DateFormatter().date(from: toDate)!, fromValue: ISO8601DateFormatter().date(from: fromDate)!)
        XCTAssertEqual(between.stringQualifier, "2017-07-04..2017-12-13")
    }

}
