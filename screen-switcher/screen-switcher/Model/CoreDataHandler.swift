//
//  CoreDataHandler.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 16/02/21.
//

import Foundation
import CoreData

struct CoreDataHandler {
    private let entityName = "Contact" // Name of an entity stored in Core Data model
    lazy var contacts: [Contact] = []
    
    // This method fetches data to populate table view upon VC being presented to the user
    mutating func fetchData(completionHandler: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Contact>(entityName: entityName)
        do {
            contacts = try managedContext.fetch(fetchRequest)
            completionHandler(true)
        } catch {
            fatalError("Failed to fetch data: \(error)")
        }
    }
    
    // Searching for data using NSPredicate
    mutating func searchData(searchString string: String, completionHandler: (_ complete: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let predicate = NSPredicate(format: "name contains %@", string)
        let fetchRequest = NSFetchRequest<Contact>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            contacts = try managedContext.fetch(fetchRequest)
            completionHandler(true)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    
}
