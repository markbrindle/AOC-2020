//
//  PasswordChecker.swift
//  AOC-2020
//
//  Created by Mark Brindle on 02/12/2020.
//

import Foundation

struct PasswordChecker {
    
    static func validate(passwords: String) -> Int {
        var validPasswordCount = 0
        
        // Separate password details to be verified into an array; one per line
        let toValidate: [String]
        if passwords.contains("\n") {
            toValidate = passwords.components(separatedBy: "\n")
        } else {
            toValidate = [passwords]
        }
        
        // Determine the number of valid passwords
        toValidate.forEach { data in
            validPasswordCount += data.isValidPassword() ? 1 : 0
        }
        return validPasswordCount
    }
}
