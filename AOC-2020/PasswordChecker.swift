//
//  PasswordChecker.swift
//  AOC-2020
//
//  Created by Mark Brindle on 02/12/2020.
//

import Foundation

struct PasswordChecker {
    
    static func validateForSledRental(passwords: String) -> Int {
        var validPasswordCount = 0
        // Determine the number of valid passwords
        PasswordChecker.getPasswordArray(from: passwords).forEach { data in
            validPasswordCount += data.validSledRentalPasswords() ? 1 : 0
        }
        return validPasswordCount
    }

    static func validateForTobogganRental(passwords: String) -> Int {
        var validPasswordCount = 0
        // Determine the number of valid passwords
        PasswordChecker.getPasswordArray(from: passwords).forEach { data in
            validPasswordCount += data.validTobogganRentalPasswords() ? 1 : 0
        }
        return validPasswordCount
    }
    
    private static func getPasswordArray(from passwords: String) -> [String] {
        // Separate password details to be verified into an array; one per line
        let toValidate: [String]
        if passwords.contains("\n") {
            toValidate = passwords.components(separatedBy: "\n")
        } else {
            toValidate = [passwords]
        }
        return toValidate
    }
}
