//
//  Validator.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import Foundation

struct Validator {
    private let phoneNumberSize = 10
    
    func isEmpty(string: String) -> Bool {
        if string == "" {
            return true
        }
        return false
    }
    
    func isValidPhoneNum(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func isValidPhoneNumLength(string: String) -> Bool {
        if string.count != phoneNumberSize {
            return false
        }
        return true
    }
    
    func isValidString(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
    }
    
    // Complete validation of phone number using all the previously declared methods
    // Returned value indicates whether phone number is valid (bool) and where (if anywhere) the error was found during validation (string)
    func validatePhoneNumber(inputString string: String) -> (String, Bool) {
        if isEmpty(string: string) {
            return ("isEmpty", false)
        }
        else if !isValidPhoneNum(string: string) {
            return ("isInvalidPhoneNum", false)
        }
        else if !isValidPhoneNumLength(string: string) {
            return ("isInvalidPhoneNumLength", false)
        }
        else { return ("", true) }
    }
    
    // Complete validation of name (first and last done separately) using all the previously declared methods
    // Returned value indicates whether phone number is valid (bool) and where (if anywhere) the error was found during validation (string)
    func validateName(inputString string: String) -> (String, Bool) {
        if isEmpty(string: string) {
            return ("isEmpty", false)
        }
        else if !isValidString(string: string) {
            return ("isInvalidString", false)
        }
        else { return ("", true) }
    }
}
