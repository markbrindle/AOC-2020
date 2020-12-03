//
//  String+Extension.swift
//  AOC-2020
//
//  Created by Mark Brindle on 03/12/2020.
//

import Foundation

extension String {
    func isValidPassword() -> Bool {
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

        // How many times does the policy value appear in the password
        let result = password.replacingOccurrences(of: policyValue, with: "", options: [], range: nil)
        let occurrences = (password.count - result.count) / policyValue.count
        
        return occurrences >= min && occurrences <= max
    }
}
