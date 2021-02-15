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
    private let entityName = "Contact" // Name of entity stored in Core Data model
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        if let savedArray = defaults.object(forKey: "Contacts") as? [[String: String]] { // Optional binding to extract contacts array from user defaults
            contactsArray = savedArray
        }
        
        self.fetchData { (complete) in
            //TODO: Complete the completion handler
            if complete {
                
            }
        }
    }
    
    func fetchData(completionHandler: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Contact>(entityName: entityName)
        do {
            contacts = try managedContext.fetch(fetchRequest)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}

extension ContactsTableVC: UITableViewDataSource {
    // Returns number of rows to display in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    // Return a cell to be allocated at the particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell {
            cell.updateView(contact: contacts[indexPath.row])
            return cell
        } else { // If tableView cell cannot be casted as ContactCell, then return a blank ContactCell object
            return ContactCell()
        }
    }
}
