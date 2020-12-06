//
//  ContentView.swift
//  AOC-2020
//
//  Created by Mark Brindle on 01/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    var toboggan = Toboggan(origin: Point(x: 0, y: 0))

    var body: some View {
        let twoItems = expenseReport1()
        let threeItems = expenseReport2()
        let validSledPasswords = validateSledPasswords()
        let validTobogganPasswords = validateTobogganPasswords()
        toboggan.navigate(through: Day_03.input)
        
        return VStack(spacing: 8) {
            VStack(spacing: 2) {
                HStack {
                    Text("Day 1 Part 1 Items :")
                    Spacer()
                    Text(twoItems.description)
                }
                HStack {
                    Text("Day 1 Part 1 Result :")
                    Spacer()
                    Text((twoItems[0] * twoItems[1]).description)
                }
            }
            VStack(spacing: 2) {
                HStack {
                    Text("Day 1 Part 2 Items :")
                    Spacer()
                    Text(threeItems.description)
                }
                HStack {
                    Text("Day 1 Part 2 Result :")
                    Spacer()
                    Text((threeItems[0] * threeItems[1] * threeItems[2]).description)
                }
            }
            VStack(spacing: 2) {
                HStack {
                    Text("Day 2 Part 1 Result :")
                    Spacer()
                    Text(validSledPasswords.description)
                }
                HStack {
                    Text("Day 2 Part 2 Result :")
                    Spacer()
                    Text(validTobogganPasswords.description)
                }
            }
            VStack(spacing: 8) {
                HStack {
                    Text("Day 3 Part 1 Result :")
                    Spacer()
                    Text("Trees encountered - \(tobogganRun(horizontal: "R3", vertical: "D1"))")
                }
                VStack (spacing: 2) {
                    Text("Day 3 Part 2 Result :")
                    HStack {
                        Text("Trees encountered for R1: D1")
                        Spacer()
                        Text(tobogganRun(horizontal: "R1", vertical: "D1"))
                    }
                    HStack {
                        Text("Trees encountered for R5: D1")
                        Spacer()
                        Text(tobogganRun(horizontal: "R5", vertical: "D1"))
                    }
                    HStack {
                        Text("Trees encountered for R7: D1")
                        Spacer()
                        Text(tobogganRun(horizontal: "R7", vertical: "D1"))
                    }
                    HStack {
                        Text("Trees encountered for R1: D2")
                        Spacer()
                        Text(tobogganRun(horizontal: "R1", vertical: "D2"))
                    }
                }
                VStack (spacing: 2) {
                    Text("Day 4 Part 2 Result :")
                    HStack {
                        Text("Valid passports: ")
                        Spacer()
                        Text("\(validatePasswords())")
                    }
                }
                VStack (spacing: 2) {
                    Text("Day 5 Part 1 Result :")
                    HStack {
                        Text("Highest Seat ID: ")
                        Spacer()
                        Text("\(SeatingLocator.highestSeatID(from: Day_05.input)?.seatID ?? 0)")
                    }
                    HStack {
                        Text("Missing Seat ID: ")
                        Spacer()
                        Text("\(findSeat())")
                    }
                }
                VStack (spacing: 2) {
                    Text("Day 6 Part 1 Result :")
                    HStack {
                        Text("Answer count: ")
                        Spacer()
                        Text("\(CustomsDeclaration.answerAnyCount(for: Day_06.input))")
                    }
                    HStack {
                        Text("All Answer count: ")
                        Spacer()
                        Text("\(CustomsDeclaration.answerAllCount(for: Day_06.input))")
                    }
                }
            }
        }.padding()
    }
    
    func expenseReport1() -> [Int] {
        var key1 = 0
        var key2 = 0
        let counter = Day_01.input.count - 1

        while key1 < counter {
            while key2 < counter {
                if (Day_01.input[key1] + Day_01.input[key2] == 2020) {
                    return [Day_01.input[key1], Day_01.input[key2]]
                }
                key2 += 1
            }
            key1 += 1
            key2 = 0
        }
        return [0, 0]
    }

    func expenseReport2() -> [Int] {
        var key1 = 0
        var key2 = 0
        var key3 = 0
        let counter = Day_01.input.count - 1
        
        while key1 < counter {
            while key2 < counter {
                while key3 < counter {
                    if (Day_01.input[key1] + Day_01.input[key2] + Day_01.input[key3] == 2020) {
                        return [
                            Day_01.input[key1],
                            Day_01.input[key2],
                            Day_01.input[key3],
                        ]
                    }
                    key3 += 1
                }
                key2 += 1
                key3 = 0
            }
            key1 += 1
            key2 = 0
        }
        return [0, 0, 0]
    }
    
    func validateSledPasswords() -> Int {
        return PasswordChecker.validateForSledRental(passwords: Day_02.input)
    }

    func validateTobogganPasswords() -> Int {
        return PasswordChecker.validateForTobogganRental(passwords: Day_02.input)
    }
    
    func tobogganRun(horizontal: String, vertical: String) -> String {
        toboggan.movement = Move(horizontal: horizontal, vertical: vertical)
        return "\(toboggan.traverseFromOrigin().replacingOccurrences(of: ".", with: "").count)"
    }
    
    func validatePasswords() -> Int {
        do {
            return try PassportBuilder.build(from: Day_04.input).filter(
                {
                    let result = $0.validate()
                    switch result {
                    case .success(let isValid): return isValid
                    case .failure(_): return false
                    }
                }).count
        } catch {
            print("Oops!")
            return 0
        }
    }
    
    func findSeat() -> Int {
        let allSeats = SeatingLocator.allSeats(from: Day_05.input)
        let sortedSeatIDs = allSeats.keys.sorted()
        var missingSeatID = 0
        var currentSeatID = sortedSeatIDs.first!
        var index = 1
        let maxIndex = sortedSeatIDs.count
        while missingSeatID == 0 {
            let prospectiveSeatID = sortedSeatIDs[index]
            if prospectiveSeatID > currentSeatID + 1 {
                missingSeatID = currentSeatID + 1
            }
            currentSeatID = prospectiveSeatID
            index += 1
            if index == maxIndex {
                missingSeatID = -1
            }
        }
        return missingSeatID
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

