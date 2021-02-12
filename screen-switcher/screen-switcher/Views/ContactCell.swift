//
//  ContactCell.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = "Hello"
    }

    func updateView(contact: [String: String]) {
        let contactName = contact["Name"]!
        let phoneNum = contact["Phone Number"]!
        nameLabel.text = "\(contactName)"
        phoneNumLabel.text = "\(phoneNum)"
    }
}
