//
//  String+Extension.swift
//  AOC-2020
//
//  Created by Mark Brindle on 03/12/2020.
//

import Foundation

extension String {

    func validSledRentalPasswords() -> Bool {
        validPasswords(policy: validateSledRental)
    }
    
    func validTobogganRentalPasswords() -> Bool {
        validPasswords(policy: validateTobogganRental)
    }
    
    private func validateSledRental(password: String, policyValue: String, min: Int, max: Int) -> Bool {
        // How many times does the policy value appear in the password
        let result = password.replacingOccurrences(of: policyValue, with: "", options: [], range: nil)
        let occurrences = (password.count - result.count) / policyValue.count
        
        return occurrences >= min && occurrences <= max
    }

    private func validateTobogganRental(password: String, policyValue: String, firstPosition: Int, secondPosition: Int) -> Bool {
        // How many times does the policy value appear in the specified positions
        let firstVal = String(password[password.index(password.startIndex, offsetBy: firstPosition - 1)])
        let secondVal = String(password[password.index(password.startIndex, offsetBy: secondPosition - 1)])
        return (firstVal == policyValue || secondVal == policyValue) && (firstVal != secondVal)
    }

    func validPasswords(policy: (_ password: String, _ policyValue: String, _ min: Int, _ max: Int) -> Bool) -> Bool {
        /*
         Unpack the policy data - e.g. 1-3 a: abcde
         
         From data we are given the password policy and then the password.
         The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
         */
        let policyComponents = self.components(separatedBy: " ")
        // The first component contains the minimum and maximum count allowed for the policy value
        // The second component contains the subString to check for.
        // The last component is the password to validate against this policy
        guard
            policyComponents.count == 3,
            let minMaxComponents = policyComponents.first?.components(separatedBy: "-"),
            minMaxComponents.count == 2,
            let minStr = minMaxComponents.first,
            let min = Int(minStr),
            let maxStr = minMaxComponents.last,
            let max = Int(maxStr),
            let policyValue = policyComponents.dropFirst().first?.replacingOccurrences(of: ":", with: ""),
            !policyValue.isEmpty,
            let password = policyComponents.last,
            !password.isEmpty
        else {
            return false
        }
        
        return policy(password, policyValue, min, max)
    }
    
}
