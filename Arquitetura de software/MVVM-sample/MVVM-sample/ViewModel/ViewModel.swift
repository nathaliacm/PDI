//
//  ViewModel.swift
//  MVVM-sample
//
//  Created by Nathalia Cardoso on 14/02/23.
//

import Foundation

class ViewModel {
    
    var mvvmModel: Model {
        didSet {
            sendEntityToView()
        }
    }
    
    public var controller: ViewController?

    var personEntity: Entity!
    
    init(model: Model) {
        self.mvvmModel = model
        
        personEntity = parsePersonModelToEntity()
    }
    
    func update(model: Model) {
        mvvmModel = model
    }
    
    func updateFirstName(to name: String) {
        mvvmModel.updateFirstName(to: name)
    }
    
    func sendEntityToView() {
        personEntity = parsePersonModelToEntity()
        controller?.updateView(entity: personEntity)
    }
    
    private func parsePersonModelToEntity() -> Entity {
        return Entity(
            fullName: "\(mvvmModel.firstName) \(mvvmModel.secondName)",
            isBrazilian: mvvmModel.country == "Brasil" ? true : false,
            isOfAge: mvvmModel.age >= 18 ? true : false
        )
    }
}

