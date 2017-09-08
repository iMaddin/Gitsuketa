//
//  GitHubSearchParameterTests.swift
//  GitsuketaTests
//
//  Created by Maddin on 06.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import XCTest
@testable import Gitsuketa

class GitHubSearchParameterTests: XCTestCase {
    
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

extension GitHubSearchParameterTests {

    func testBasicQuery() {
        let searchKeyword = "tetris"
        let searchQuery = GitHubSearchQuery(keyword: searchKeyword)
        let searchParameter = GitHubSearchParameter(query: searchQuery)

        let expectation = "https://api.github.com/search/repositories?q=tetris&sort=match&order=desc"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testQueryWithWhiteSpace() {
        let searchKeyword = "Rocket League"
        let searchQuery = GitHubSearchQuery(keyword: searchKeyword)
        let searchParameter = GitHubSearchParameter(query: searchQuery)

        let expectation = "https://api.github.com/search/repositories?q=Rocket+League&sort=match&order=desc"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

}
