//
//  LuggageHandlerTests.swift
//  AOC-2020Tests
//
//  Created by Mark Brindle on 07/12/2020.
//

import XCTest
@testable import AOC_2020

/*
 --- Day 7: Handy Haversacks ---

 You land at the regional airport in time for your next flight. In fact, it looks like you'll even have time to grab some food: all flights are currently delayed due to issues in luggage processing.

 Due to recent aviation regulations, many rules (your puzzle input) are being enforced about bags and their contents; bags must be color-coded and must contain specific quantities of other color-coded bags. Apparently, nobody responsible for these regulations considered how long they would take to enforce!

 For example, consider the following rules:

light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
 
 These rules specify the required contents for 9 bag types. In this example, every faded blue bag is empty, every vibrant plum bag contains 11 bags (5 faded blue and 6 dotted black), and so on.

 You have a shiny gold bag. If you wanted to carry it in at least one other bag, how many different bag colors would be valid for the outermost bag? (In other words: how many colors can, eventually, contain at least one shiny gold bag?)

 In the above rules, the following options would be available to you:

 - A bright white bag, which can hold your shiny gold bag directly.
 - A muted yellow bag, which can hold your shiny gold bag directly, plus some other bags.
 - A dark orange bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
 - A light red bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
 
 So, in this example, the number of bag colors that can eventually contain at least one shiny gold bag is 4.

 How many bag colors can eventually contain at least one shiny gold bag? (The list of rules is quite long; make sure you get all of it.)
 */

class LuggageHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLightRedBagsContain_3_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
"""
        let ruleName = "light red"
        let expectedBagCount = 3
        
        // When
        let handler = LuggageHandler(for: rules)
        let bagRule = handler.allowedContent(for: ruleName)
        
        // Then
        XCTAssertNotNil(bagRule, "\(ruleName) has no rules")
        XCTAssertEqual(expectedBagCount, bagRule!.totalBagsCount(), "Incorrect contents for \(bagRule!.name)")
    }

    func testTwoBagsContain_5_Bags() throws {
        // Given
        let rules =
"""
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
"""
        let expectedBagCount = 8
        
        // When
        let handler = LuggageHandler(for: rules)
        let luggageRules = handler.rules
        let totalBags = luggageRules
            .map { $0.totalBagsCount() }
            .reduce(0, +)
        
        // Then
        XCTAssertNotNil(rules, "handler has no rules")
        XCTAssertEqual(expectedBagCount, totalBags, "Incorrect bag count for rules")
    }

    func testABagsContainingNoBagsReturns_0_Bags() throws {
        // Given
        let rules =
"""
faded blue bags contain no other bags.
"""
        let expectedBagCount = 0
        
        // When
        let handler = LuggageHandler(for: rules)
        let luggageRules = handler.rules
        let totalBags = luggageRules
            .map { $0.totalBagsCount() }
            .reduce(0, +)
        
        // Then
        XCTAssertNotNil(rules, "handler has no rules")
        XCTAssertEqual(expectedBagCount, totalBags, "Incorrect bag count for rules")
    }

    func testTwoBagsContainingNoBagsReturns_0_Bags() throws {
        // Given
        let rules =
"""
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 0
        
        // When
        let handler = LuggageHandler(for: rules)
        let luggageRules = handler.rules
        let totalBags = luggageRules
            .map { $0.totalBagsCount() }
            .reduce(0, +)
        
        // Then
        XCTAssertNotNil(rules, "handler has no rules")
        XCTAssertEqual(expectedBagCount, totalBags, "Incorrect bag count for rules")
    }

    func testGoldBagCanBeContainedIn_4_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 4
        
        // When
        let handler = LuggageHandler(for: rules)
        let totalBags = handler.containers(for: "shiny gold")
        
        // Then
        XCTAssertEqual(expectedBagCount, totalBags.count, "Incorrect bag count for rules")
    }

    func testFadedBlueBagCanBeContainedIn_8_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 8
        
        // When
        let handler = LuggageHandler(for: rules)
        let totalBags = handler.containers(for: "faded blue")
        
        // Then
        XCTAssertEqual(expectedBagCount, totalBags.count, "Incorrect bag count for rules")
    }

    func testMutedYellowBagCanBeContainedIn_2_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 2
        
        // When
        let handler = LuggageHandler(for: rules)
        let totalBags = handler.containers(for: "muted yellow")
        
        // Then
        XCTAssertEqual(expectedBagCount, totalBags.count, "Incorrect bag count for rules")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let handler = LuggageHandler(for: Day_07.input)
            let totalBags = handler.containers(for: "shiny gold")
            print(totalBags.count)
        }
    }

    /*
     --- Part Two ---

     It's getting pretty expensive to fly these days - not because of ticket prices, but because of the ridiculous number of bags you need to buy!

     Consider again your shiny gold bag and the rules from the above example:

     faded blue bags contain 0 other bags.
     dotted black bags contain 0 other bags.
     vibrant plum bags contain 11 other bags: 5 faded blue bags and 6 dotted black bags.
     dark olive bags contain 7 other bags: 3 faded blue bags and 4 dotted black bags.
     So, a single shiny gold bag must contain 1 dark olive bag (and the 7 bags within it) plus 2 vibrant plum bags (and the 11 bags within each of those): 1 + 1*7 + 2 + 2*11 = 32 bags!

     Of course, the actual rules have a small chance of going several levels deeper than this example; be sure to count all of the bags, even if the nesting becomes topologically impractical!

     Here's another example:

     shiny gold bags contain 2 dark red bags.
     dark red bags contain 2 dark orange bags.
     dark orange bags contain 2 dark yellow bags.
     dark yellow bags contain 2 dark green bags.
     dark green bags contain 2 dark blue bags.
     dark blue bags contain 2 dark violet bags.
     dark violet bags contain no other bags.
     In this example, a single shiny gold bag must contain 126 other bags.

     How many individual bags are required inside your single shiny gold bag?
     */
    
    func testFadedBlueBagContains_0_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 0
        
        // When
        let handler = LuggageHandler(for: rules)
        let totalBags = handler.totalContainedBags(for: "faded blue")
        
        // Then
        XCTAssertEqual(expectedBagCount, totalBags, "Incorrect bag count for rules")
    }

    func testVibrantPlumBagContains_11_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 11
        
        // When
        let handler = LuggageHandler(for: rules)
        let totalBags = handler.totalContainedBags(for: "vibrant plum")
        
        // Then
        XCTAssertEqual(expectedBagCount, totalBags, "Incorrect bag count for rules")
    }

    func testShinyGoldBagContains_32_Bags() throws {
        // Given
        let rules =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""
        let expectedBagCount = 32
        
        // When
        let handler = LuggageHandler(for: rules)
        let totalBags = handler.totalContainedBags(for: "shiny gold")
        
        // Then
        XCTAssertEqual(expectedBagCount, totalBags, "Incorrect bag count for rules")
    }
    
    func testPerformance() throws {
        // This is an example of a performance test case.
        self.measure {
            let handler = LuggageHandler(for: Day_07.input)
            let totalBags = handler.totalContainedBags(for: "shiny gold")
            print(totalBags)
        }
    }
}
