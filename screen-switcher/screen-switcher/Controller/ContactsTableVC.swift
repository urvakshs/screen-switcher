//
//  ContactsTableVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 11/02/21.
//

import UIKit
import CoreData

class ContactsTableVC: UIViewController, UITableViewDelegate {
        
    @IBOutlet weak var contactsTableView: UITableView!
    let defaults = UserDefaults.standard
    private var contactsArray: [[String: String]]! // An array of contact dictionaries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting this VC as the delegate and data source of the contacts table view
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        /*
        if let savedArray = defaults.object(forKey: "Contacts") as? [[String: String]] { // Optional binding to extract contacts array from user defaults
            contactsArray = savedArray
        }*/
        
        CoreDataHandler.shared.fetchData { (complete) in
            if complete {
                print("Data fetched successfully")
            }
        }
    }
    
    // Perform search on what is typed in
    @IBAction func textFieldEdited(_ sender: UITextField) {
        if let newText = sender.text {
            // Perform search on unwrapped string
            CoreDataHandler.shared.searchData(searchString: newText) { (complete) in
                if complete {
                    DispatchQueue.main.async {
                        self.contactsTableView.reloadData()
                    }
                }
            }
        }
    }
}

extension ContactsTableVC: UITableViewDataSource {
    // Returns number of rows to display in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataHandler.shared.contacts.count
    }
    
    // Return a cell to be allocated at the particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell {
            cell.updateView(contact: CoreDataHandler.shared.contacts[indexPath.row])
            return cell
        } else { // If tableView cell cannot be casted as ContactCell, then return a blank ContactCell object
            return ContactCell()
        }
    }
}
