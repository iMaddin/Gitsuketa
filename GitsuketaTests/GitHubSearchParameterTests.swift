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

    let api = "https://api.github.com/search/repositories?q="
    let sortOrder = "&sort=match&order=desc"
    let searchKeyword = "tetris"

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
        let expectation = "\(api)tetris\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testQueryWithWhiteSpace() {
        let searchKeyword = "Rocket League"
        let searchQuery = GitHubSearchQuery(keyword: searchKeyword)
        let searchParameter = GitHubSearchParameter(query: searchQuery)
        let expectation = "\(api)Rocket+League\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testQueryWithTrailingWhiteSpaceAndAdditionalParameters() {
        let parameter = "There is whitespace to the right of this text       "
        let searchQuery = GitHubSearchQuery(keyword: parameter)
        let searchParameter = GitHubSearchParameter(query: searchQuery)
        let expectation = "\(api)There+is+whitespace+to+the+right+of+this+text\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testRepoUserInputWithTrailingWhiteSpace() {
        let parameter = "iMaddin     "
        var searchQuery = GitHubSearchQuery(keyword: searchKeyword)
        searchQuery.user = parameter
        let searchParameter = GitHubSearchParameter(query: searchQuery)
        let expectation = "\(api)\(searchKeyword)+org:iMaddin\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testUserUserInputWithTrailingWhiteSpace() {
        let parameter = "iMaddin     "
        var searchQuery = GitHubSearchQuery(keyword: searchKeyword)
        searchQuery.user = parameter
        let searchParameter = GitHubSearchParameter(query: searchQuery)
        let expectation = "\(api)\(searchKeyword)+user:iMaddin\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testTopicUserInputWithTrailingWhiteSpace() {
        let parameter = "Swift     "
        var searchQuery = GitHubSearchQuery(keyword: searchKeyword)
        searchQuery.topic = [parameter]
        let searchParameter = GitHubSearchParameter(query: searchQuery)
        let expectation = "\(api)\(searchKeyword)+topic:Swift\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testKeywordWithPrependedWhitespace() {
        let parameter = "   tetris"
        let searchQuery = GitHubSearchQuery(keyword: parameter)
        let searchParameter = GitHubSearchParameter(query: searchQuery)
        let expectation = "\(api)tetris\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

}

extension GitHubSearchParameterTests {

    // created
    // pushed
    // fork
    // numberOfForks
    // searchFields
    // language
    // repo
    // user
    // size
    // numberOfStars
    // topic

    func testCreatedParameter() {
        let parameter = ISO8601DateFormatter().date(from: "2017-07-07T00:00:00+00:00")!
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.created = GitHubRangeValue(value: parameter)
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+created:2017-07-07\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testPushedParameter() {
        let parameter = ISO8601DateFormatter().date(from: "2017-07-07T00:00:00+00:00")!
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.pushed = GitHubRangeValue(value: parameter)
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+pushed:2017-07-07\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testForkParameter() {
        let parameter = GitHubForkSearchOption.includeForks
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.fork = parameter
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+fork:\(parameter.rawValue)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testNumberOfForksParameter() {
        let parameter = 23
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.numberOfForks = GitHubRangeValue(value: parameter)
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+forks:\(parameter)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testSearchFieldsParameter() {
        let parameter = GitHubSearchField.readme
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.searchFields = [parameter]
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+in:\(parameter.rawValue)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testLanguageParameter() {
        let parameter = GitHubLanguage.Swift
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.language = parameter
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+language:\(parameter.rawValue)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testRepoParameter() {
        let parameter = "github"
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.repo = parameter
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+org:\(parameter)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testUserParameter() {
        let parameter = "iMaddin"
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.user = parameter
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+user:\(parameter)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testSizeParameter() {
        let parameter = 1000
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.size = GitHubRangeValue(value: parameter)
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+size:\(parameter)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testNumberOfStarsParameter() {
        let parameter = 23
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.numberOfStars = GitHubRangeValue(value: 23)
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+stars:\(parameter)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

    func testTopicParameter() {
        let parameter = "react-native"
        var q = GitHubSearchQuery(keyword: searchKeyword)
        q.topic = [parameter]
        let searchParameter = GitHubSearchParameter(query: q)
        let expectation = "\(api)\(searchKeyword)+topic:\(parameter)\(sortOrder)"
        XCTAssertEqual(searchParameter.url?.absoluteString, expectation)
    }

}
