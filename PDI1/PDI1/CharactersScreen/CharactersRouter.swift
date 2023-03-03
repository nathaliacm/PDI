//
//  CharactersRouter.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 02/03/23.
//

import Foundation
import UIKit

typealias CharactersEntryPoint = CharactersViewControllerProtocol & UIViewController

protocol CharactersRouterProtocol: AnyObject {
    var entry: CharactersEntryPoint? { get }
    
    static func assemble(with path: String) -> CharactersRouterProtocol
}

class CharactersRouter: CharactersRouterProtocol {
    var entry: CharactersEntryPoint?
    
    static func assemble(with path: String) -> CharactersRouterProtocol {
        let router = CharactersRouter()
        
        let view: CharactersViewControllerProtocol = CharactersViewController()
        let presenter: CharactersPresenterProtocol = CharactersPresenter()
        let interactor: CharactersInteractorProtocol = CharactersInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.path = path
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? CharactersEntryPoint
        
        return router
    }
}

