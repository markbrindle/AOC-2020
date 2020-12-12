//
//  JoltageAdapter.swift
//  AOC-2020
//
//  Created by Mark Brindle on 11/12/2020.
//

import Foundation

struct JoltageAdapter {
    static func chain(_ data: String) -> Int {
        let joltAdapters =
            data
            .components(separatedBy: "\n")
            .compactMap { Int($0) }
            .sorted()
        
        let minJoltStep = 1
        let maxJoltStep = 3
        
        var joltStepMin = 0
        var joltStepMax = 0
        
        // First adapter must have a joltage less that maxJoltStep or we can't connect to it
        guard let first = joltAdapters.first, 0 < first, first < maxJoltStep else {
            return 0
        }
        
        if first == minJoltStep {
            joltStepMin = 1
        } else if first == maxJoltStep {
            joltStepMax = 1
        }
        
        // Add to the current rating, so long as diff is minJoltStep or maxJoltStep
        for i in 1 ..< joltAdapters.count {
            let diff = joltAdapters[i] - joltAdapters[i - 1]
            
            if diff > maxJoltStep {
                return -1
            }
            
            if diff == minJoltStep {
                joltStepMin += 1
            } else if diff == maxJoltStep {
                joltStepMax += 1
            }

            // The max joltage difference between adapters is maxJoltStep
            if diff > maxJoltStep {
                return 0
            }
        }
        
        // Supportable joltage is current rating plus maxJoltStep
        joltStepMax += 1
        return joltStepMin * joltStepMax
    }
}
