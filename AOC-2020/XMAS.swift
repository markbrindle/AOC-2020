//
//  XMAS.swift
//  AOC-2020
//
//  Created by Mark Brindle on 10/12/2020.
//

import Foundation

struct XMAS {
    static func validate(data: String, preamble: Int) -> Int64 {
        let cypher = data
            .components(separatedBy: "\n")
            .compactMap { Int64($0) }
        
        for i in preamble ..< cypher.count {
            let validators = cypher[i - preamble ... i]
            var matchFound = false
            let numberToValidate = cypher[i]
            innerLoop: for j in i - preamble ..< i {
                for k in i - preamble ..< i {
                    if numberToValidate == validators[j] + validators[k] && j != k {
                        matchFound = true
                        break innerLoop
                    }
                }
            }
            if !matchFound {
                return cypher[i]
            }
        }
        return -1
    }
}
