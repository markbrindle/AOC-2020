//
//  CustomsDeclaration.swift
//  AOC-2020
//
//  Created by Mark Brindle on 06/12/2020.
//

import Foundation

struct CustomsDeclaration {
    static func answerCount(for answers: String) -> Int {

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
