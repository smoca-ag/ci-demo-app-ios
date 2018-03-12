//
//  Demo_iOSTests.swift
//  Demo-iOSTests
//
//  Created by Luiz on 13.02.18.
//  Copyright © 2018 smoca. All rights reserved.
//

import XCTest
@testable import Demo_iOS

class Demo_iOSTests: XCTestCase {
    let body = Body(weight: 70, andHeight: 180)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBMICalc() {
        guard let bmi = body?.getBmi() else {
            return
        }

        XCTAssertTrue(bmi == 22)
    }
    
}
