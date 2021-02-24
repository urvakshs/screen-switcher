//
//  iTunesSearchVC.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 23/02/21.
//

import UIKit

class iTunesSearchVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var iTunesTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var songsArray: [Song] = []
    var searchResultsManager = SearchResultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        iTunesTableView.delegate = self
        iTunesTableView.dataSource = self
        searchResultsManager.delegate = self
        self.iTunesTableView.rowHeight = 120;
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        if let searchText = searchTextField.text {
            searchResultsManager.fetchSongs(searchString: searchText)
            //searchResultsManager.fetchImage()
        }
    }
}

// MARK: Table View Data Source Methods
extension iTunesSearchVC: UITableViewDataSource {
    // Returns number of rows to display in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }
    
    // Return a cell to be allocated at the particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell") as? MusicCell {
            cell.updateView(song: songsArray[indexPath.row])
            return cell
        } else { // If tableView cell cannot be casted as ContactCell, then return a blank ContactCell object
            return MusicCell()
        }
    }
}

// MARK: Search Results Delegate Methods
extension iTunesSearchVC: SearchResultsManagerDelegate {
    func didUpdateCells(_ searchData: SearchData) {
        songsArray = searchData.results
        print(searchData.results)
        // Changes to UI must be done on main thread
        DispatchQueue.main.async {
            self.iTunesTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    
}
