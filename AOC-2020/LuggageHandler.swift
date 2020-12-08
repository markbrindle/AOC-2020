//
//  LuggageHandler.swift
//  AOC-2020
//
//  Created by Mark Brindle on 07/12/2020.
//

import Foundation

struct LuggageRule {
    let name: String
    let bagContents: [String : Int]
    
    init(name: String, contents: String) {
        self.name = name
        
        var allowedContents: [String : Int] = [:]
        
        let bagCounts = contents.components(separatedBy: ", ")
        bagCounts.forEach { content in
                /* Content will hold one of these
                    - no other bags.
                    - 1 <name> bag
                    - 1 <name> bag.
                    - n <name> bags
                    - n <name> bags.
                 Note: name may have spaces
                */
                if content == "no other bags." {
                    allowedContents[name] = 0
                } else {
                    // Find the number(s) up to the first space
                    let countIndex = content.firstIndex(of: " ") ?? content.endIndex
                    let num = Int(content[..<countIndex])
                    // Drop the last part
                    let bagIndex = content.lastIndex(of: " ") ?? content.endIndex
                    let name = String(content[content.index(after: countIndex)..<bagIndex])
                    allowedContents[name] = num
                }
            }
        self.bagContents = allowedContents
    }
    
    func totalBagsCount() -> Int {
        bagContents.values.reduce(0, +)
    }
}

extension LuggageRule: Hashable {
    
}

struct LuggageHandler {
    let rules: [LuggageRule]
    
    init(for data: String) {
        func processRule(ruleData: String) -> LuggageRule? {
            let luggageDetails = ruleData.components(separatedBy: " bags contain ")
            guard
                let name = luggageDetails.first,
                let contents = luggageDetails.last
            else {
                return nil
            }
            return LuggageRule(name: name, contents: contents)
        }
        
        if data.contains("\n") {
            self.rules = data
                .components(separatedBy: "\n")
                .compactMap { processRule(ruleData: $0) }
        } else {
            if let rule = processRule(ruleData: data) {
                self.rules = [rule]
            } else {
                self.rules = []
            }
        }
    }
    
    func allowedContent(for bagName: String) -> LuggageRule? {
        rules.first(where: { $0.name == bagName })
    }
    
    func containers(for bagName: String) -> [LuggageRule] {
        func containersFor(_ bagName: String) -> Set<LuggageRule> {
            var bagContainers = Set<LuggageRule>()
            rules
                .filter {
                    $0.bagContents.keys.contains(bagName)
                }
                .forEach {
                    bagContainers.insert($0)
                }
            return bagContainers
        }
        
        var bagContainers = Set<LuggageRule>()
        
        var bags = containersFor(bagName)
        
        while bags.count > 0 {
            // Get new bags to process
            let newBags = bags.subtracting(bagContainers)
            bags.forEach{ bagContainers.insert($0) }
            
            bags.removeAll()
            newBags.forEach{
                containersFor($0.name)
                    .forEach {
                        bags.insert($0)
                    }
            }
        }
        return Array(bagContainers)
    }
    
    func totalContainedBags(for bagName: String) -> Int {
        
        var bags = 0
        
        guard let rule = rules.first(where: { (rule) -> Bool in
            rule.name == bagName
        }) else {
            return bags
        }
        // For each contained bag get the number of bags it contains
        
        rule.bagContents.forEach { (key, value) in
            if value > 0 {
                bags += value * (1 + totalContainedBags(for: key))
            }
        }
        return bags
    }
}
