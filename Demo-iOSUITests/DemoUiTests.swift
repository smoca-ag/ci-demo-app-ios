//
//  Demo_iOSUITests.swift
//  Demo-iOSUITests
//
//  Created by Luiz on 13.02.18.
//  Copyright © 2018 smoca. All rights reserved.
//

import XCTest

class DemoUiTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let gewichtInKgElementsQuery = app.otherElements.containing(.staticText, identifier: "Gewicht (in kg)")
        let textField = gewichtInKgElementsQuery.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("70")
        
        let textField2 = gewichtInKgElementsQuery.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("180")
        app.buttons["Berechnen"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "bmiOutputLabel").label, "22")
        
    }
}
