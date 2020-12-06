//
//  SeatingLocator.swift
//  AOC-2020
//
//  Created by Mark Brindle on 06/12/2020.
//

import Foundation

struct Seat {
    let row: Int
    let column: Int
    var seatID: Int
}

struct SeatingLocator {
    static func seat(for boardingPass: String) -> Seat? {
        let rowString = boardingPass.prefix(7)
        let columnString = boardingPass.suffix(3)

        let binaryRowString = rowString.replacingOccurrences(of: "B", with: "1").replacingOccurrences(of: "F", with: "0")
        let binaryColumnString = columnString.replacingOccurrences(of: "R", with: "1").replacingOccurrences(of: "L", with: "0")
        
        guard
            let row = Int(binaryRowString, radix: 2),
            let column = Int(binaryColumnString, radix: 2)
        else {
            return nil
        }
        
        return Seat(row: row, column: column, seatID: (row * 8 + column))
    }

    static func highestSeatID(from boardingPasses: String) -> Seat? {
        var seat = Seat(row: 0, column: 0, seatID: 0)
        
        if boardingPasses.contains("\n") {
            let passesArray = boardingPasses.components(separatedBy: "\n")
            passesArray.forEach { (boardingPass) in
                if let aSeat = SeatingLocator.seat(for: boardingPass) {
                    if aSeat.seatID > seat.seatID {
                        seat = aSeat
                    }
                }
            }
            return seat
        } else {
            return SeatingLocator.seat(for: boardingPasses)
        }
    }

    static func allSeats(from boardingPasses: String) -> [Int : Seat] {
        var seats: [Int : Seat] = [ : ]
        
        if boardingPasses.contains("\n") {
            let passesArray = boardingPasses.components(separatedBy: "\n")
            passesArray.forEach { (boardingPass) in
                if let seat = SeatingLocator.seat(for: boardingPass) {
                    seats[seat.seatID] = seat
                }
            }
        } else {
            if let seat = SeatingLocator.seat(for: boardingPasses) {
                seats[seat.seatID] = seat
            }
        }

        return seats
    }
}
