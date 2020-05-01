//
//  iTableDemoUITests.swift
//  iTableDemoUITests
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import XCTest

class ITableDemoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewController() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.tableRows.count, 0)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Flag"]/*[[".cells.staticTexts[\"Flag\"]",".staticTexts[\"Flag\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        XCTAssertEqual(app.tables.count, 1)
    }
}
