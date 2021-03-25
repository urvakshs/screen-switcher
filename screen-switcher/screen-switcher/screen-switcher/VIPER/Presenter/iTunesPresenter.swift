//
//  iTunesPresenter.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 24/03/21.
//

import Foundation

class iTunesPresenter: ViewToPresenterProtocol {
    // Delegates for different parts of the VIPER principle (View, Interactor, Router)
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func fetchSongs(queryString: String) {
        let modifiedSearchStr = queryString.replacingOccurrences(of: " ", with: "+")
        // TODO: ERROR CODE IS UNUSED. IMPLEMENT IT!
        interactor?.performRequest(forURL: "https://itunes.apple.com/search?media=music&term=\(modifiedSearchStr)")
    }
}

extension iTunesPresenter: InteractorToPresenterProtocol {
    
    // When the interactor reports a failure to the presenter, presenter must update the view
    func failure() {
        view?.songsRequestFailure()
    }
    
    // When the data is fetched successfully, presenter must update the view
    func success(songsList: [SongDetails]) {
        view?.songsRequestSuccess(songsList: songsList)
    }
}
