//
//  iTunesPresenter.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 24/03/21.
//

import Foundation

class iTunesPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func fetchSongs(queryString: String) {
        let modifiedSearchStr = queryString.replacingOccurrences(of: " ", with: "+")
        let errorCode = interactor?.performRequest(forURL: "https://itunes.apple.com/search?media=music&term=\(modifiedSearchStr)")
    }
}

extension iTunesPresenter: InteractorToPresenterProtocol {
    func failure() {
        view?.songsRequestFailure()
    }
    
    func success(songsList: [SongDetails]) {
        view?.songsRequestSuccess(songsList: songsList)
    }
}
