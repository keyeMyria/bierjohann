//
//  UtilityFunctionsTests.swift
//  bierjohannTests
//
//  Created by Kohler Manuel on 25.09.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import XCTest
@testable import bierjohann

class UtilityFunctionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
 
    }
    
    func testURLEncodingSucceeds () {
        XCTAssertEqual("some%20string", prepareStringForURLSearch(s: "some string"))
    }
    
//    func testURLAmpersand() {
//        XCTAssertEqual("a%26b", prepareStringForURLSearch(s: "a&b"))
//    }
    
    
    
}
