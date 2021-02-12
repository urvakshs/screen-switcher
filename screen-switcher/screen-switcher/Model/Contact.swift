//
//  Contact.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import Foundation

// Struct containing details entered for each new contact/user
struct Contact: Equatable { // Equatable needed for "contains" method to check for existence in array
    var name: String
    var phoneNumber: String
    
    init(firstName: String, lastName: String, phoneNum: String) {
        self.name = "\(firstName) " + "\(lastName)"
        self.phoneNumber = phoneNum
    }
}
