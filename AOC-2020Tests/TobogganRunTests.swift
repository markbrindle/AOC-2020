//
//  TobogganRunTests.swift
//  AOC-2020Tests
//
//  Created by Mark Brindle on 03/12/2020.
//

import XCTest
@testable import AOC_2020

/*
 --- Day 3: Toboggan Trajectory ---

 With the toboggan login problems resolved, you set off toward the airport. While travel by toboggan might be easy, it's certainly not safe: there's very minimal steering and the area is covered in trees. You'll need to see which angles will take you near the fewest trees.

 Due to the local geology, trees in this area only grow on exact integer coordinates in a grid. You make a map (your puzzle input) of the open squares (.) and trees (#) you can see. For example:

..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
 
 These aren't the only trees, though; due to something you read about once involving arboreal genetics and biome stability, the same pattern repeats to the right many times:

..##.........##.........##.........##.........##.........##.......  --->
#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....  --->
.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
.#........#.#........#.#........#.#........#.#........#.#........#
#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
#...##....##...##....##...##....##...##....##...##....##...##....#
.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#  --->

 You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).

 The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:

 From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.

 The locations you'd check in the above example are marked here with O where there was an open square and X where there was a tree:

..##.........##.........##.........##.........##.........##.......  --->
#..O#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
.#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
..#.#...#O#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
.#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##.....  --->
.#.#.#....#.#.#.#.O..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
.#........#.#........X.#........#.#........#.#........#.#........#
#.##...#...#.##...#...#.X#...#...#.##...#...#.##...#...#.##...#...
#...##....##...##....##...#X....##...##....##...##....##...##....#
.#..#...#.#.#..#...#.#.#..#...X.#.#..#...#.#.#..#...#.#.#..#...#.#  --->

 In this example, traversing the map using this slope would cause you to encounter 7 trees.

 Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?
 */

class TobogganRunTests: XCTestCase {

    let forest =
"""
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovingToAnEmptySpaceReturnsO() throws {
        // Given
        let expectedOutcome = "."
        let toboggan = Toboggan(origin: Point(x: 0, y: 0))
        toboggan.navigate(through: forest)
        toboggan.movement = Move(horizontal: "R3", vertical: "D1")

        // When
        let actualOutcome = toboggan.travelOneMove()
        
        // Then
        XCTAssertEqual(expectedOutcome, actualOutcome, "Toboggan encounterd an obstacle")
    }

    func testMovingToAnOccupiedSpaceReturnsHash() throws {
        // Given
        let expectedOutcome = "#"
        let toboggan = Toboggan(origin: Point(x: 0, y: 0))
        toboggan.navigate(through: forest)
        toboggan.movement = Move(horizontal: "R3", vertical: "D1")

        // When
        _ = toboggan.travelOneMove()
        let actualOutcome = toboggan.travelOneMove()
        
        // Then
        XCTAssertEqual(expectedOutcome, actualOutcome, "Toboggan encounterd an obstacle")
    }

    func testTwoMovesToAnOccupiedSpaceReturnsHash() throws {
        // Given
        let expectedOutcome = "#"
        let toboggan = Toboggan(origin: Point(x: 0, y: 0))
        toboggan.navigate(through: forest)
        toboggan.movement = Move(horizontal: "R4", vertical: "D3")

        // When
        let actualOutcome = toboggan.travelOneMove()
        
        // Then
        XCTAssertEqual(expectedOutcome, actualOutcome, "Toboggan encounterd an obstacle")
    }

    func testTraversingTheForrestReturnLandingSpots() throws {
        // Given
        let expectedOutcome = ".#.##.####"
        let toboggan = Toboggan(origin: Point(x: 0, y: 0))
        toboggan.navigate(through: forest)
        toboggan.movement = Move(horizontal: "R3", vertical: "D1")

        // When
        let actualOutcome = toboggan.traverse()
        
        // Then
        XCTAssertEqual(expectedOutcome, actualOutcome, "Toboggan encounterd an obstacle")
    }
    
    func testActualTerrain() throws {
        // Given
        let expectedOutcome = "#.#..#.######.###..####.#..##...###..#....###......#.....###..#.######.#....#..##......##....#..#.....#..###..#.#......#..#...###.#..###.#....##..#.#####.#....#.#.#.##.##....#.#..###..##.#...#....#.##.####.#.##.##....#.##.###..#.###.#....#..#.##....#.##.#.#..###.#..##...#..###..#.........####..#.#..#########...#.#..##..."
        let expectedTrees = 148
        let toboggan = Toboggan(origin: Point(x: 0, y: 0))
        toboggan.navigate(through: Day_03.input)
        toboggan.movement = Move(horizontal: "R3", vertical: "D1")

        // When
        let actualOutcome = toboggan.traverse()
        let treesEncountered = actualOutcome.replacingOccurrences(of: ".", with: "").count
        
        // Then
        XCTAssertEqual(expectedOutcome, actualOutcome, "Toboggan encounterd an obstacle")
        XCTAssertEqual(expectedTrees, treesEncountered, "Did not encounter the trees expected")
    }

    func testPerformanceExample() throws {
        var treesEncountered: Int = 0
        self.measure {
            let toboggan = Toboggan(origin: Point(x: 0, y: 0))
            toboggan.navigate(through: Day_03.input)
            toboggan.movement = Move(horizontal: "R3", vertical: "D1")
            treesEncountered = toboggan.traverse().replacingOccurrences(of: ".", with: "").count
        }
        print("treesEncountered = \(treesEncountered)")
    }

}
