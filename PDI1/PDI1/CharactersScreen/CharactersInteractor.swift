//
//  CharactersInteractor.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 02/03/23.
//

import Foundation

protocol CharactersInteractorProtocol: AnyObject {
    var path: String? { get set }
    var presenter: CharactersPresenterProtocol? { get set }
    
    func getData()
}

class CharactersInteractor: CharactersInteractorProtocol {
    weak var presenter: CharactersPresenterProtocol?
    var path: String?
    
    func getData() {
        guard let urlPath = path?.appending("?page=1") else { return }
        guard let url = URL(string: urlPath) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchData(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(ResultsEntity.self, from: data)
                
                self?.presenter?.interactorDidFetchData(with: .success(entities.results))
            }
            catch {
                self?.presenter?.interactorDidFetchData(with: .failure(error))
            }
        }
        
        task.resume()
    }
}
