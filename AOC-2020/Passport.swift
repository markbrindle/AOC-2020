//
//  Passport.swift
//  AOC-2020
//
//  Created by Mark Brindle on 05/12/2020.
//

import Foundation

enum PassportDataKey: String {
    case birthYear      = "byr"
    case issueYear      = "iyr"
    case expirationYear = "eyr"
    case height         = "hgt"
    case hairColor      = "hcl"
    case eyeColor       = "ecl"
    case passportID     = "pid"
    case countryID      = "cid"
}

enum PassportError: Error {
    case emptyData
    case invalidData
    case parsingError
}

class Passport {
    var error: PassportError?
    
    let birthYear: String?
    let issueYear: String?
    let expirationYear: String?
    let height: String?
    let hairColor: String?
    let eyeColor: String?
    let passportID: String?
    let countryID: String?
    
    convenience init(from dataString: String) throws {
        // Parse the dataString
        let dataStringArray: [String]
        
        if dataString.contains("\n") {
            dataStringArray = dataString.components(separatedBy: "\n")
        } else {
            dataStringArray = [dataString]
        }
        
        var passportItems: [PassportDataKey : String] = [ : ]
        
        let processPassportItem: (String) throws -> () = { passportItem in
            let passportComponents = passportItem.components(separatedBy: ":")
            guard
                passportComponents.count == 2,
                let keyString = passportComponents.first,
                let key = PassportDataKey.init(rawValue: keyString),
                let value = passportComponents.last
            else {
                throw PassportError.parsingError
            }
            passportItems[key] = value
        }

        try dataStringArray.forEach { item in
            if item.contains(" ") {
                let items = item.components(separatedBy: " ")
                try items.forEach { passportItem in try processPassportItem(passportItem) }
            } else {
                try processPassportItem(item)
            }
        }
        self.init(from: passportItems)
    }
    
    required init(from data: [PassportDataKey : String]) {
        birthYear = data[PassportDataKey.birthYear]
        issueYear = data[PassportDataKey.issueYear]
        expirationYear = data[PassportDataKey.expirationYear]
        height = data[PassportDataKey.height]
        hairColor = data[PassportDataKey.hairColor]
        eyeColor = data[PassportDataKey.eyeColor]
        passportID = data[PassportDataKey.passportID]
        countryID = data[PassportDataKey.countryID]
    }
    
    func validate() -> Result<Bool, Error> {
        guard error == nil else {
            // Parsing error occurred
            return .failure(error!)
        }
        guard
            // byr (Birth Year) - four digits; at least 1920 and at most 2002.
            let birthYear = birthYear,
            let birthYr = Int(birthYear),
            birthYr >= 1920,
            birthYr <= 2002,
            
            // iyr (Issue Year) - four digits; at least 2010 and at most 2020.
            let issueYear = issueYear,
            let issueYr = Int(issueYear),
            issueYr >= 2010,
            issueYr <= 2020,

            // eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
            let expirationYear = expirationYear,
            let expirationYr = Int(expirationYear),
            expirationYr >= 2020,
            expirationYr <= 2030,

            // hgt (Height) - a number followed by either cm or in:
            let height = height,
            height.count > 2,

            // hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
            let hairColor = hairColor,
            hairColor.count == 7,
            hairColor.hasPrefix("#"),

            // ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
            let eyeColor = eyeColor,
            Set.init(arrayLiteral: "amb", "blu", "brn", "gry", "grn", "hzl", "oth").contains(eyeColor),

            // pid (Passport ID) - a nine-digit number, including leading zeroes.
            let passportID = passportID,
            passportID.count == 9,
            let _ = Int(passportID)

            // cid (Country ID) - ignored, missing or not.
        else {
            return .success(false)
        }

        // Validate height depending on imperial or metric measurement
        // If cm, the number must be at least 150 and at most 193.
        let heightMeasure = height.suffix(2)
        guard let heightMeasurement = Int(height.dropLast(2)) else {
            return .success(false)
        }
        if heightMeasure == "cm" {
            if (heightMeasurement < 150 || heightMeasurement > 193) {
                return .success(false)
            }
        } else if heightMeasure == "in" {
            // If in, the number must be at least 59 and at most 76.
            if (heightMeasurement < 59 || heightMeasurement > 76) {
                return .success(false)
            }
        } else {
            return .success(false)
        }
        
        return .success(true)
    }
}
