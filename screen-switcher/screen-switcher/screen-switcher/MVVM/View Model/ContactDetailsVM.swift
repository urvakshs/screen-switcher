//
//  ContactDetailsVM.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/03/21.
//

import Foundation

struct ContactDetailsVM {
    private var model: ContactDetails
    
    // Initialise the model that this viewModel gets its data from
    init(contactName: String, contactPhone: String, contactEmail: String) {
        model = ContactDetails(name: contactName, email: contactEmail, phone: contactPhone)
    }
    
    // Simple read-only computed properties that can be used by a VC to display in labels
    var name: String {
        return "YOUR NAME IS: \(model.name)"
    }
    
    var phoneNum: String {
        return "YOUR PHONE NUMBER IS: \(model.phoneNum)"
    }
    
    var email: String {
        return "YOUR EMAIL IS: \(model.email)"
    }

}
