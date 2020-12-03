//
//  PasswordCheckerTests.swift
//  AOC-2020Tests
//
//  Created by Mark Brindle on 02/12/2020.
//

import XCTest
@testable import AOC_2020

class PasswordCheckerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ValidPasswordReturns_1() throws {
        // Given
        let stringToCheck =
            """
            1-3 a: abcde
            """
        let expected = 1
        
        // When
        let actual = PasswordChecker.validate(passwords: stringToCheck)
        
        // Then
        XCTAssertEqual(actual, expected, "Password should be valid")
    }
    
    func test_twoValidPasswordsReturns_2() throws {
        // Given
        let stringToCheck =
            """
            1-3 a: abcde
            2-9 c: ccccccccc
            """
        
        let expected = 2
        
        // When
        let actual = PasswordChecker.validate(passwords: stringToCheck)
        
        // Then
        XCTAssertEqual(actual, expected, "Two passwords should be valid")
    }

    func test_inalidPasswordReturns_0() throws {
        // Given
        let stringToCheck =
            """
            1-3 b: cdefg
            """

        let expected = 0
        
        // When
        let actual = PasswordChecker.validate(passwords: stringToCheck)
        
        // Then
        XCTAssertEqual(actual, expected, "Password should be invalid")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
