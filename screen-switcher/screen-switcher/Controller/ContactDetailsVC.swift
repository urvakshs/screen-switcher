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
        var validity: Bool
        
        // Perform validation on first name
        (errorCode, validity) = validator.validateName(inputString: firstNameField.text!)
        if validity == false {
            if errorCode == "isEmpty" {
                print("First name field is empty. Please input something")
            }
            else {
                print("First name field contains invalid characters. Please use letters only")
            }
            return
        }
        
        // Perform validation on last name
        (errorCode, validity) = validator.validateName(inputString: secondNameField.text!)
        if validity == false {
            if errorCode == "isEmpty" {
                print("Second name field is empty. Please input something")
            }
            else {
                print("Second name field contains invalid characters. Please use letters only")
            }
            return
        }
        
        // Perform validation on phone number
        (errorCode, validity) = validator.validatePhoneNumber(inputString: phoneNumberField.text!)
        if validity == false {
            if errorCode == "isEmpty" {
                print("Phone number field is empty. Please input something")
            }
            else if errorCode == "isInvalidPhoneNum" {
                print("Phone number contains invalid characters such as letters or special characters. Please input only numbers")
            }
            else {
                print("Phone number is not of valid length. Phone number contains 10 digits (without extension)")
            }
            return
        }
        
        // Only add to array if such a contact does not already exist
        let userDict = ["Name": "\(firstNameField.text!) " + "\(secondNameField.text!)", "Phone Number": phoneNumberField.text!]
        if !contactsArray!.contains(userDict) {
            contactsArray!.append(userDict)
        }
        defaults.set(contactsArray, forKey: "Contacts")
        
        save(completionHandler: { (complete) in
            // Perform segue once data is saved succcessfully
            if complete {
                performSegue(withIdentifier: segueIdentifier, sender: self)
            }
        }, name: "\(firstNameField.text!) " + "\(secondNameField.text!)", phoneNumber: phoneNumberField.text!)
        
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // Save data using Core Data
    func save(completionHandler: (_ finished: Bool) -> (), name: String, phoneNumber: String) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let contact = Contact(context: managedContext)
        contact.name = "\(firstNameField.text!) " + "\(secondNameField.text!)"
        contact.phoneNumber = phoneNumberField.text!
        
        do {
            try managedContext.save()
            completionHandler(true)
        } catch {
            fatalError("Could not save \(error.localizedDescription)")
        }
    }
}
