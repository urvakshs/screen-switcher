//
//  ContactDetails.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/03/21.
//

import Foundation

struct ContactDetails {
    let name: String
    let email: String
    let phoneNum: String
    
    init(name: String, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phoneNum = phone
    }
}
