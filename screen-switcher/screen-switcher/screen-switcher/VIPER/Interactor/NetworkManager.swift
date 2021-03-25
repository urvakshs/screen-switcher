//
//  NetworkManager.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 24/03/21.
//

import Foundation
import Network

class NetworkManager {
    let monitor = NWPathMonitor()
    var presenter: InteractorToPresenterProtocol?

    func parseJSON(_ searchData: Data) -> SearchResults? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchResults.self, from: searchData)
            return decodedData
        } catch {
            presenter?.failure()
            return nil
        }
    }
}

extension NetworkManager: PresenterToInteractorProtocol {
    
    // This function will return error codes for different instances:
    
    // 0 = No error/Successful request
    // 1 = No internet
    func performRequest(forURL urlString: String) -> Int {
        var errorCode = 0 // Initialise with no error
        
        // Create a closure that will return an error code of 1 when there is no internet connection availability.
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                errorCode = 1
            }
        }
        
        //let queue = DispatchQueue(label: "Monitor")
        //monitor.start(queue: queue)

        // 1. Create a URL
        if let url = URL(string: urlString) { // Optional binding
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil { // Print any error if there is one
                    self.presenter?.failure()
                    return
                }
                if let safeData = data { // Optional binding to ensure Data? optional is safely unwrapped
                    if let songsData = self.parseJSON(safeData) {
                        self.presenter?.success(songsList: songsData.results)
                    }
                }
            }
            // 4. Start the task
            task.resume() // Newly initialised tasks need to be resumed since they are in a suspended state
        }
        return errorCode
    }
}
