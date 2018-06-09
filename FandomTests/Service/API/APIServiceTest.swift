//
//  APIServiceTest.swift
//  FandomTests
//
//  Created by Guilherme Carvalho on 09/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import XCTest
@testable import Fandom

class APIServiceTest: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        expectation = self.expectation(description: "delegate")
    }
    
    // MARK: - Public
    
    func success() {
        XCTAssertTrue(true)
        expectation?.fulfill()
    }
    
    func failure(_ failure: ServiceFailureType) {
        if failure == .server {
            XCTFail("server service error")
        } else {
            XCTFail("connection service error")
        }
        expectation?.fulfill()
    }
    
}
