//
//  WikisTableViewControllerUITest.swift
//  FandomUITests
//
//  Created by Guilherme Carvalho on 09/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import XCTest

class WikisTableViewControllerUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testClickRow() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let cellQuery = tablesQuery.cells.containing(.staticText, identifier: "WikiCell")
        let cell = cellQuery.children(matching: .staticText).firstMatch
        XCTAssertFalse(cell.exists, "Found element, so app didn't open safari")
    }
    
}