//
//  PersistencyTests.swift
//  PersistencyTests
//
//  Created by Luka Kramer on 19.10.20.
//

import XCTest
@testable import Persistency

class PersistencyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWriteArray() throws {
        let array = ["Bube", "Dame", "König"]
        let checkObject: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        checkObject.saveStringArray(array)
        
        XCTAssertEqual(array, checkObject.loadStringArray())
    }
    
    func testWriteArrayNotEqual() throws {
        let array = ["Bube", "Dame", "König"]
        let array2 = ["Ass"]
        let checkObject: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        checkObject.saveStringArray(array)
        
        XCTAssertNotEqual(checkObject.loadStringArray(), array2)
    }
}
