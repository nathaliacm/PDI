//
//  Model.swift
//  MVVM-sample
//
//  Created by Nathalia Cardoso on 14/02/23.
//

public struct Model: Codable {
    var firstName: String
    var secondName: String
    var country: String
    var age: Int
}

// MARK: Mockar dados para consumo
extension Model {
  static let mockedPerson = Model(
    firstName: "Fulado",
    secondName: "Da silva",
    country: "Brasil",
    age: 25
  )
}

// MARK: Pegar dados do model
extension Model {
    func getData() -> Model {
        return self
    }
}

// MARK: Fazer mudanças no model
extension Model {
    mutating func updateFirstName(to name: String) {
        self.firstName = name
    }
}
