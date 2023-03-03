//
//  Presenter.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 27/02/23.
//

import Foundation
import UIKit

enum FetchError: Error {
    case failed
}

protocol PresenterProtocol: AnyObject {
    var router: RouterProtocol? { get set }
    var interactor: InteractorProtocol? { get set }
    var view: ViewControllerProtocol? { get set }
    
    func interactorDidFetchData(with result: Result<Entity, Error>)
    func loadCharacters(with path: String)
}

class Presenter: PresenterProtocol {
    var router: RouterProtocol?
    
    var interactor: InteractorProtocol? {
        didSet {
            interactor?.getData()
        }
    }
    
    weak var view: ViewControllerProtocol?
    
    func interactorDidFetchData(with result: Result<Entity, Error>) {
        switch result {
        case .success(let entity):
            DispatchQueue.main.async {
                self.view?.updateView(with: entity)
            }
        case .failure:
            view?.updateView(with: ":(")
        }
    }
    
    func loadCharacters(with path: String) {
        router?.loadCharacters(with: path)
    }
}
