//
//  SeatingLocatorTests.swift
//  AOC-2020Tests
//
//  Created by Mark Brindle on 06/12/2020.
//

import XCTest
@testable import AOC_2020

/*
 --- Day 5: Binary Boarding ---

 You board your plane only to discover a new problem: you dropped your boarding pass! You aren't sure which seat is yours, and all of the flight attendants are busy with the flood of people that suddenly made it through passport control.

 You write a quick program to use your phone's camera to scan all of the nearby boarding passes (your puzzle input); perhaps you can find your seat through process of elimination.

 Instead of zones or groups, this airline uses binary space partitioning to seat people. A seat might be specified like FBFBBFFRLR, where F means "front", B means "back", L means "left", and R means "right".

 The first 7 characters will either be F or B; these specify exactly one of the 128 rows on the plane (numbered 0 through 127). Each letter tells you which half of a region the given seat is in. Start with the whole list of rows; the first letter indicates whether the seat is in the front (0 through 63) or the back (64 through 127). The next letter indicates which half of that region the seat is in, and so on until you're left with exactly one row.

 For example, consider just the first seven characters of FBFBBFFRLR:

 - Start by considering the whole range, rows 0 through 127.
 - F means to take the lower half, keeping rows 0 through 63.
 - B means to take the upper half, keeping rows 32 through 63.
 - F means to take the lower half, keeping rows 32 through 47.
 - B means to take the upper half, keeping rows 40 through 47.
 - B keeps rows 44 through 47.
 - F keeps rows 44 through 45.
 - The final F keeps the lower of the two, row 44.
 
 The last three characters will be either L or R; these specify exactly one of the 8 columns of seats on the plane (numbered 0 through 7). The same process as above proceeds again, this time with only three steps. L means to keep the lower half, while R means to keep the upper half.

 For example, consider just the last 3 characters of FBFBBFFRLR:

 - Start by considering the whole range, columns 0 through 7.
 - R means to take the upper half, keeping columns 4 through 7.
 - L means to take the lower half, keeping columns 4 through 5.
 - The final R keeps the upper of the two, column 5.
 
 So, decoding FBFBBFFRLR reveals that it is the seat at row 44, column 5.

 Every seat also has a unique seat ID: multiply the row by 8, then add the column. In this example, the seat has ID 44 * 8 + 5 = 357.

 Here are some other boarding passes:

 - BFFFBBFRRR: row 70, column 7, seat ID 567.
 - FFFBBBFRRR: row 14, column 7, seat ID 119.
 - BBFFBBFRLL: row 102, column 4, seat ID 820.
 
 As a sanity check, look through your list of boarding passes. What is the highest seat ID on a boarding pass?
*/

class SeatingLocatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeatingLocatorReturns_Row44_Column5_SeatID_357() throws {
        // Given
        let boardingPass = "FBFBBFFRLR"
        let expectedRow = 44
        let expectedColumn = 5
        let expectedSeatID = 357
        
        // When
        guard let seat = SeatingLocator.seat(for: boardingPass) else {
            XCTFail("Failed to get a seat for boarding pass \(boardingPass)")
            return
        }
        
        // Then
        XCTAssertEqual(expectedRow, seat.row, "Incorrect row for seat")
        XCTAssertEqual(expectedColumn, seat.column, "Incorrect column for seat")
        XCTAssertEqual(expectedSeatID, seat.seatID, "Incorrect seat ID for seat")
    }

    func testSeatingLocatorReturns_Row70_Column7_SeatID_567() throws {
        // Given
        let boardingPass = "BFFFBBFRRR"
        let expectedRow = 70
        let expectedColumn = 7
        let expectedSeatID = 567
        
        // When
        guard let seat = SeatingLocator.seat(for: boardingPass) else {
            XCTFail("Failed to get a seat for boarding pass \(boardingPass)")
            return
        }
        
        // Then
        XCTAssertEqual(expectedRow, seat.row, "Incorrect row for seat")
        XCTAssertEqual(expectedColumn, seat.column, "Incorrect column for seat")
        XCTAssertEqual(expectedSeatID, seat.seatID, "Incorrect seat ID for seat")
    }

    func testSeatingLocatorReturns_Row14_Column7_SeatID_119() throws {
        // Given
        let boardingPass = "FFFBBBFRRR"
        let expectedRow = 14
        let expectedColumn = 7
        let expectedSeatID = 119
        
        // When
        guard let seat = SeatingLocator.seat(for: boardingPass) else {
            XCTFail("Failed to get a seat for boarding pass \(boardingPass)")
            return
        }
        
        // Then
        XCTAssertEqual(expectedRow, seat.row, "Incorrect row for seat")
        XCTAssertEqual(expectedColumn, seat.column, "Incorrect column for seat")
        XCTAssertEqual(expectedSeatID, seat.seatID, "Incorrect seat ID for seat")
    }

    func testSeatingLocatorReturns_Row102_Column4_SeatID_820() throws {
        // Given
        let boardingPass = "BBFFBBFRLL"
        let expectedRow = 102
        let expectedColumn = 4
        let expectedSeatID = 820
        
        // When
        guard let seat = SeatingLocator.seat(for: boardingPass) else {
            XCTFail("Failed to get a seat for boarding pass \(boardingPass)")
            return
        }
        
        // Then
        XCTAssertEqual(expectedRow, seat.row, "Incorrect row for seat")
        XCTAssertEqual(expectedColumn, seat.column, "Incorrect column for seat")
        XCTAssertEqual(expectedSeatID, seat.seatID, "Incorrect seat ID for seat")
    }
    
    func testHighestBoardingPass_Returns_820() {
        // Given
        let boardingPasses =
"""
FBFBBFFRLR
BBFFBBFRLL
BFFFBBFRRR
FFFBBBFRRR
"""
        let expectedSeatID = 820
        
        // When
        guard let seat = SeatingLocator.highestSeatID(from: boardingPasses) else {
            XCTFail("Failed to get highest seat from boarding passes \(boardingPasses)")
            return
        }
        
        // Then
        XCTAssertEqual(expectedSeatID, seat.seatID, "Incorrect seat ID for seat")
    }
    
    /*
     --- Part Two ---

     Ding! The "fasten seat belt" signs have turned on. Time to find your seat.

     It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.

     Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.

     What is the ID of your seat?
     */
    
    func testLowestBoardingPass_Returns_119() {
        // Given
        let boardingPasses =
"""
FBFBBFFRLR
BBFFBBFRLL
BFFFBBFRRR
FFFBBBFRRR
"""
        let expectedSeatID = 119
        
        // When
        var lowestSeatID: Int = 0
        let seats = SeatingLocator.allSeats(from: boardingPasses)
        if seats.isEmpty {
            XCTFail("Failed to get all seats from boarding passes \(boardingPasses)")
        } else {
            lowestSeatID = seats.keys.sorted().first!
        }
        
        // Then
        XCTAssertEqual(expectedSeatID, lowestSeatID, "Incorrect seat ID for seat")
    }
    

    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
