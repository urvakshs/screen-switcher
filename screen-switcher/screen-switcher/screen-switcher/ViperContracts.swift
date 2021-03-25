//
//  ViperContracts.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 24/03/21.
//

import Foundation

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchSongs(queryString: String)
}

protocol PresenterToViewProtocol: class {
    func songsRequestSuccess(songsList: [SongDetails])
    func songsRequestFailure()
}

protocol PresenterToRouterProtocol: class {
    static func iTunesRouting(view: iTunesViewController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    func performRequest(forURL urlString: String) -> Int
}

protocol InteractorToPresenterProtocol: class {
    func failure()
    func success(songsList: [SongDetails])
}

