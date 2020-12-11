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
    
    static func exploit(for data: String, weakness: Int64) -> Int64 {
        let cypher = data
            .components(separatedBy: "\n")
            .compactMap { Int64($0) }
            
        var sum = Int64(0)

        for i in 0 ..< cypher.count {
            sum = Int64(0)
            var contiguousNumbers = [Int64]()
            var n = i
            while sum < weakness && n < cypher.count {
                let num = cypher[n]
                if sum + num > weakness {
                    // This is not the exploit you are looking for
                    break
                }
                contiguousNumbers.append(num)
                
                if sum + num == weakness && contiguousNumbers.count >= 1 {
                    let sorted = contiguousNumbers.sorted()
                    return sorted.first! + sorted.last!
                }
                sum += num
                n += 1
            }
        }
        
        // Couldn't find an exploit
        return -1
    }
}
