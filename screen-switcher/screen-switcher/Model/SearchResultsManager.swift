//
//  SearchResultsManager.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/02/21.
//

import Foundation

protocol SearchResultsManagerDelegate { // Using delegation design principle so that data can be easily shared with iTunesSearchVC
    func passPreviewURLString(_ previewString: String)
    func didUpdateCells(_ searchData: SearchData)
    func didFailWithError(error: Error)
}

struct SearchResultsManager {
    let iTunesURL = "https://itunes.apple.com/search?media=music&term=" // API base URL configured for only music
    var delegate: SearchResultsManagerDelegate?
    
    func fetchSongs(searchString: String) {
        // Since the API does not accept whitespaces in queries, we must replace them with + symbols
        let modifiedSearchStr = searchString.replacingOccurrences(of: " ", with: "+")
        let urlString = "\(iTunesURL)\(modifiedSearchStr)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) { // Optional binding
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil { // Print any error if there is one
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data { // Optional binding to ensure Data? optional is safely unwrapped
                    if let songsData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCells(songsData)
                    }
                }
            }
            // 4. Start the task
            task.resume() // Newly initialised tasks need to be resumed since they are in a suspended state
        }
    }
    
    func parseJSON(_ searchData: Data) -> SearchData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchData.self, from: searchData)
            //print("decodedData in parseJSON = \(decodedData)")
            return decodedData
        } catch {
            //delegate?.didFailWithError(error: error)
            print("Error in decoding data: \(error.localizedDescription)")
            return nil
        }
    }
}
