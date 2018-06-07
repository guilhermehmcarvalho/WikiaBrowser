//
//  FandomUITests.swift
//  FandomUITests
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import XCTest

class FandomUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
		
        continueAfterFailure = false
        XCUIApplication().launch()
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
