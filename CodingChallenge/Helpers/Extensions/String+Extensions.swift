//
//  String+Extensions.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 24/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import Foundation
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword() -> Bool {
         var lowerCaseLetter: Bool = false
         var upperCaseLetter: Bool = false
         var digit: Bool = false
         var specialCharacter: Bool = false

         if self.count  >= 8 {
             for char in self.unicodeScalars {
                 if !lowerCaseLetter {
                     lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
                 }
                 if !upperCaseLetter {
                     upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
                 }
                 if !digit {
                     digit = CharacterSet.decimalDigits.contains(char)
                 }
                 if !specialCharacter {
                     specialCharacter = CharacterSet.punctuationCharacters.contains(char)
                 }
             }
             if specialCharacter || (digit && lowerCaseLetter && upperCaseLetter) {
                 //do what u want
                 return true
             }
             else {
                 return false
             }
         }
         return false
     }
    
    var utf8String: UnsafePointer<Int8>? {
        (self as NSString).utf8String
    }
    
    var trimmed: String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
}


