//
//  iTunesRouter.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 25/03/21.
//

import Foundation

class iTunesRouter: PresenterToRouterProtocol {
     static func iTunesRouting(view: iTunesViewController) {
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = iTunesPresenter()
        
        view.presenter = presenter
        view.presenter?.router = iTunesRouter()
        view.presenter?.view = view
        view.presenter?.interactor = NetworkManager()
        view.presenter?.interactor?.presenter = presenter
    }
}
