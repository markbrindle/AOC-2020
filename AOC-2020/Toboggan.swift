//
//  Toboggan.swift
//  AOC-2020
//
//  Created by Mark Brindle on 03/12/2020.
//

import Foundation

struct Point {
    let x: Int
    let y: Int
}

struct Move {
    let horizontal: String
    let vertical: String
}

typealias Terrain = [String]

class Toboggan {
    private var origin: Point
    private var move: Point
    private var terrain: Terrain {
        didSet {
            if terrain.isEmpty {
                terrainWidth = 0
                terrainHeight = 0
            } else {
                terrainHeight = terrain.count
                terrainWidth = terrain.first?.count ?? 0
            }
        }
    }
    private var terrainWidth: Int
    private var terrainHeight: Int
    private var currentPosition: Point
    
    var movement: Move {
        didSet {
            calculateMove()
        }
    }
    
    init(origin: Point) {
        self.origin = origin
        self.currentPosition = origin
        movement = Move(horizontal: "R0", vertical: "D0")
        move = Point(x: 0, y: 0)
        terrainWidth = 0
        terrainHeight = 0
        terrain = []
    }
    
    func navigate(through topology: String) {
        if topology.contains("\n") {
            terrain = topology.components(separatedBy: "\n")
        } else {
            terrain = [topology]
        }
    }
    
    func travelOneMove() -> String {
        // Move right & down through the map from the current position by the number of spaces determined from move
        var newX = currentPosition.x + move.x
        let newY = currentPosition.y + move.y
        // Has the top or bottom of the terrain map been reached
        if newY > terrainHeight - 1 {
            return ""
        } else if newY < 0 {
            return ""
        }
        // Find the terrain row
        let terrace = terrain[newY]
        // If the terrace has been traversed to far to the right (or left), wrap around to the beginning
        if newX > terrainWidth - 1 {
            newX -= terrainWidth
        } else if newX < 0 {
            newX += terrainWidth
        }
        currentPosition = Point(x: newX, y: newY)
        return String(terrace[terrace.index(terrace.startIndex, offsetBy: newX)])
        /*
        ..##.......
        #..O#...#..
        .#....X..#.
        ..#.#...#O#
        .#...##..#.
        ..#.##.....
        .#.#.#....#
        .#........#
        #.##...#...
        #...##....#
        .#..#...#.#
        */
    }
    
    func traverseFromOrigin() -> String {
        currentPosition  = Point(x: 0, y: 0)
        return traverse()
    }

    func traverse() -> String {
        var path = ""
        var spot = travelOneMove()
        while spot != "" {
            path += spot
            spot = travelOneMove()
        }
        return path
    }

    private func calculateMove() {
        let horizontal = movement.horizontal
        var horizontalSteps = Int(horizontal.replacingOccurrences(of: "[LR]", with: "",options: .regularExpression)) ?? 0
        let horizontalDirection = horizontal[horizontal.index(horizontal.startIndex, offsetBy: 0)]
        if horizontalDirection == "L" {
            horizontalSteps *= -1
        }
        let vertical = movement.vertical
        var verticalSteps = Int(vertical.replacingOccurrences(of: "[DU]", with: "", options: .regularExpression)) ?? 0
        let verticalDirection = vertical[vertical.index(vertical.startIndex, offsetBy: 0)]
        if verticalDirection == "U" {
            verticalSteps *= -1
        }
        
        move = Point(x: horizontalSteps, y: verticalSteps)
    }

}
