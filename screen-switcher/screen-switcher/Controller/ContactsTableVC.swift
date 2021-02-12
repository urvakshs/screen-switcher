//
//  ContactsTableVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import UIKit

class ContactsTableVC: UIViewController, UITableViewDelegate {
        
    @IBOutlet weak var contactsTableView: UITableView!
    let defaults = UserDefaults.standard
    private var contactsArray: [[String: String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        if let savedArray = defaults.object(forKey: "Contacts") as? [[String: String]] {
            contactsArray = savedArray
        }
    }
}

extension ContactsTableVC: UITableViewDataSource {
    
    // Returns number of rows to display in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell {
            cell.updateView(contact: contactsArray[indexPath.row])
            return cell
        } else {
            return ContactCell()
        }
    }
}
