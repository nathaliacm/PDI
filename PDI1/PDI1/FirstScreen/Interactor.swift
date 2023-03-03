//
//  Interactor.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 27/02/23.
//

import Foundation

protocol InteractorProtocol: AnyObject {
    var presenter: PresenterProtocol? { get set }
    
    func getData()
}

class Interactor: InteractorProtocol {
    weak var presenter: PresenterProtocol?
    
    func getData() {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchData(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entity = try JSONDecoder().decode(Entity.self, from: data)
                
                self?.presenter?.interactorDidFetchData(with: .success(entity))
            }
            catch {
                self?.presenter?.interactorDidFetchData(with: .failure(error))
            }
        }
        
        task.resume()
    }
}
