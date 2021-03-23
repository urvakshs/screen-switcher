//
//  ContactDetailsVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import UIKit
import CoreData

// Instance of app delegate needed for Core Data (accessible across all files in project)
let appDelegate = UIApplication.shared.delegate as? AppDelegate // Instance created outside class to be accessible by all files

class ContactDetailsVC: UIViewController {
    
    private var contactsArray: [[String: String]]!
    private let segueIdentifier = "contactDetailsToTable"
    private let validator = Validator() // Validator object to be used for validating text fields
    private let defaults = UserDefaults.standard // Initialise user defaults
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var secondNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let savedArray = defaults.object(forKey: "Contacts") as? [[String: String]] {
            contactsArray = savedArray
        } else {
            contactsArray = []
        }
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        var errorCode: String
        var isValid: Bool
        
        // Perform validation on first name
        (errorCode, isValid) = validator.validateName(inputString: firstNameField.text!)
        // If first name is invalid, print the corresponding error message depending on the error code returned from validator
        if !isValid {
            validator.printErrorMessage(fieldName: validator.firstNameField, errorCode: errorCode)
            return
        }
        
        // Perform validation on last name
        (errorCode, isValid) = validator.validateName(inputString: secondNameField.text!)
        // If last name is invalid, print the corresponding error message depending on the error code returned from validator
        if !isValid {
            validator.printErrorMessage(fieldName: validator.secondNameField, errorCode: errorCode)
            return
        }
        
        // Perform validation on phone number
        (errorCode, isValid) = validator.validatePhoneNumber(inputString: phoneNumberField.text!)
        // If phone number is invalid, print the corresponding error message depending on the error code returned from validator
        if !isValid {
            validator.printErrorMessage(fieldName: validator.phoneNumField, errorCode: errorCode)
            return
        }
        
        // Only add to array of contact dictionaries if such a contact does not already exist
        let userDict = ["Name": "\(firstNameField.text!) " + "\(secondNameField.text!)", "Phone Number": phoneNumberField.text!]
        if !contactsArray!.contains(userDict) {
            contactsArray!.append(userDict)
        }
        defaults.set(contactsArray, forKey: "Contacts")
        
        CoreDataHandler.shared.save(completionHandler: { (complete) in
            // Perform segue once data is saved succcessfully
            if complete {
                performSegue(withIdentifier: segueIdentifier, sender: self)
            }
        }, name: "\(firstNameField.text!) " + "\(secondNameField.text!)", phoneNumber: phoneNumberField.text!)
        
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}
