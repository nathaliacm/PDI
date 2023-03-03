//
//  CharactersPresenter.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 02/03/23.
//

import Foundation

protocol CharactersPresenterProtocol: AnyObject {
    var router: CharactersRouterProtocol? { get set }
    var interactor: CharactersInteractorProtocol? { get set }
    var view: CharactersViewControllerProtocol? { get set }
    
    func interactorDidFetchData(with result: Result<[CharactersEntity], Error>)
}

class CharactersPresenter: CharactersPresenterProtocol {
    var router: CharactersRouterProtocol?
    
    var interactor: CharactersInteractorProtocol? {
        didSet {
            interactor?.getData()
        }
    }
    
    weak var view: CharactersViewControllerProtocol?
    
    func interactorDidFetchData(with result: Result<[CharactersEntity], Error>) {
        switch result {
        case .success(let entities):
            view?.updateView(with: entities)
        case .failure:
            view?.updateView(with: ":(")
        }
    }
}

