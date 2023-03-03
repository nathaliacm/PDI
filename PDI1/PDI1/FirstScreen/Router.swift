//
//  Router.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 27/02/23.
//

import Foundation
import UIKit

typealias EntryPoint = ViewControllerProtocol & UIViewController

protocol RouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    
    static func assemble() -> RouterProtocol
    func loadCharacters(with path: String)
}

class Router: RouterProtocol {
    var entry: EntryPoint?
    
    static func assemble() -> RouterProtocol {
        let router = Router()
        
        let view: ViewControllerProtocol = ViewController()
        let presenter: PresenterProtocol = Presenter()
        let interactor: InteractorProtocol = Interactor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func loadCharacters(with path: String) {
        let charactersRouter = CharactersRouter.assemble(with: path)
        guard let entryVC = charactersRouter.entry else { return }
        
        guard let viewController = self.entry else {return}
        viewController.navigationController?.pushViewController(entryVC, animated: true)
    }
}
