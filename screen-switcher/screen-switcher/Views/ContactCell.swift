//
//  ContactCell.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import UIKit

// Custom cell class for displaying contact data on table view
class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Method called whenever cell needs to be updated with new information
    func updateView(contact: [String: String]) {
        let contactName = contact["Name"]!
        let phoneNum = contact["Phone Number"]!
        nameLabel.text = "\(contactName)"
        phoneNumLabel.text = "\(phoneNum)"
    }
    
    func updateView(contact: Contact) {
        if let contactName = contact.name, let phoneNumber = contact.phoneNumber {
            nameLabel.text = contactName
            phoneNumLabel.text = phoneNumber
        }
    }
}
