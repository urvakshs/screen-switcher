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
    
    private var selectedSongURL: String?
    var songsArray: [Song] = []
    var searchResultsManager = SearchResultsManager()
    let segueIdentifier = "searchToAudioPlayback"
    let alertGenerator = AlertGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        iTunesTableView.delegate = self
        iTunesTableView.dataSource = self
        searchResultsManager.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        self.iTunesTableView.rowHeight = 120 // Needed to this line because my constraints kept failing and resizing the rows...
        if let searchText = searchTextField.text {
            let errorCode = searchResultsManager.fetchSongs(searchString: searchText)
            
            // If there is an issue in internet connectivity
            if errorCode == 1 {
                // Create a new alert
                var noNetAlert = alertGenerator.generateAlert(withTitle: "No connection to internet found. Please try again!", withMessage: "")
                // Add an action to the alert (OK button)
                noNetAlert = alertGenerator.addAction(withTitle: "OK", forAlert: noNetAlert)
                // UI Changes to be performed on main thread
                DispatchQueue.main.async {
                    self.present(noNetAlert, animated: true) { // Completion handler is unused in this case
                        return
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSongURL = songsArray[indexPath.row].previewUrl // The song URL that will be sent to the audio player VC
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? audioPlayerVC {
            destinationVC.urlString = selectedSongURL
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
        } else { // If tableView cell cannot be casted as MusicCell, then return a blank MusicCell object
            return MusicCell()
        }
    }
}

// MARK: Search Results Delegate Methods
extension iTunesSearchVC: SearchResultsManagerDelegate {
    // This function will only be used in the audioPlayerVC class (to pass over the URL of the selected song)
    // Hence, this function only returns in this VC
    func passPreviewURLString(_ previewString: String) {
        return
    }
    
    func didUpdateCells(_ searchData: SearchData) {
        songsArray = searchData.results
        // Changes to UI done on main thread
        DispatchQueue.main.async {
            self.iTunesTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

