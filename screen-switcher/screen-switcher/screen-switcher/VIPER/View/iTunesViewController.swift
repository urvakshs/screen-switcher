//
//  iTunesViewController.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 24/03/21.
//

import UIKit

class iTunesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchResultsTable: UITableView!
    
    private var songsArray: [SongDetails] = []
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTable.dataSource = self
        iTunesRouter.iTunesRouting(view: self)
        print(presenter!)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let queryString = searchBar.text {
            presenter?.fetchSongs(queryString: queryString)
        }
    }
}

extension iTunesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = searchResultsTable.dequeueReusableCell(withIdentifier: "iTunesCell", for: indexPath) as? iTunesCell {
            cell.artistNameLabel.text = songsArray[indexPath.row].artistName
            cell.songNameLabel.text = songsArray[indexPath.row].trackCensoredName
            return cell
        }
        else {
            // Return blank cell if allocating a new cell fails
            return iTunesCell()
        }
    }
}

extension iTunesViewController: PresenterToViewProtocol {
    func songsRequestSuccess(songsList: [SongDetails]) {
        songsArray = songsList
        DispatchQueue.main.async {
            self.searchResultsTable.reloadData()
        }
    }
    
    func songsRequestFailure() {
        print("Error in fetching or parsing song details.")
    }
}
