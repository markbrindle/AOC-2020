//
//  CustomsDeclaration.swift
//  AOC-2020
//
//  Created by Mark Brindle on 06/12/2020.
//

import Foundation

struct CustomsDeclaration {
    static func answerAllCount(for answers: String) -> Int {
        func processGroup(_ group: String) {
            if group.contains("\n") {
                // Count distinct answers appearing for all group members
                var groupAnswers = Set<Character>()
            
                var answered = false
                let people = group.components(separatedBy: "\n")
                people.forEach { (personAnswers) in
                    var distinctAnswers = Set<Character>()
                    personAnswers.forEach { (answer) in
                        distinctAnswers.insert(answer)
                    }
                    if groupAnswers.isEmpty && !answered {
                        groupAnswers = distinctAnswers
                        answered = true
                    } else {
                        groupAnswers = groupAnswers.intersection(distinctAnswers)
                    }
                }
                groups.append(groupAnswers.count)
            } else {
                // One person, so count all answers
                groups.append(group.count)
            }
        }

        var groups: [Int] = []
        
        // Groups are separated by blank lines; within a group one person's answers per line
        if answers.contains("\n\n") {
            let groupAnswers = answers.components(separatedBy: "\n\n")
            groupAnswers.forEach { (group) in
                processGroup(group)
            }
        } else {
            processGroup(answers)
        }
        return groups.reduce(0, +)
    }

    static func answerAnyCount(for answers: String) -> Int {
        func processGroup(_ group: String) {
            // Remove any linebreaks & count distinct entries
            var distinctAnswers = Set<Character>()
            group.replacingOccurrences(of: "\n", with: "").forEach { (answer) in
                distinctAnswers.insert(answer)
            }
            groups.append(distinctAnswers.count)
        }

        var groups: [Int] = []
        
        // Groups are separated by blank lines; within a group combine into one string
        if answers.contains("\n\n") {
            let groupAnswers = answers.components(separatedBy: "\n\n")
            groupAnswers.forEach { (group) in
                processGroup(group)
            }
        } else {
            processGroup(answers)
        }
        return groups.reduce(0, +)
    }
}
