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
    private var contactsArray: [[String: String]]! // An array of dictionaries (contacts)
    
    // An object that has all the necessary methods needed for fetching and searching for data within Core Data
    private var coreDataHandler = CoreDataHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        /*
        if let savedArray = defaults.object(forKey: "Contacts") as? [[String: String]] { // Optional binding to extract contacts array from user defaults
            contactsArray = savedArray
        }*/
        
        coreDataHandler.fetchData { (complete) in
            if complete {
                print("Data fetched successfully")
            }
        }
    }
    
    // Perform search on what is typed in
    @IBAction func textFieldEdited(_ sender: UITextField) {
        if let newText = sender.text {
            // Perform search on unwrapped string
            coreDataHandler.searchData(searchString: newText) { (complete) in
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
        return coreDataHandler.contacts.count
    }
    
    // Return a cell to be allocated at the particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell {
            cell.updateView(contact: coreDataHandler.contacts[indexPath.row])
            return cell
        } else { // If tableView cell cannot be casted as ContactCell, then return a blank ContactCell object
            return ContactCell()
        }
    }
}
