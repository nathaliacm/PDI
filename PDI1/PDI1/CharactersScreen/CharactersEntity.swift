//
//  CharactersEntity.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 02/03/23.
//

import Foundation

import UIKit

public struct ResultsEntity: Codable, Hashable {
    let results: [CharactersEntity]
}

public struct CharactersEntity: Codable, Hashable {
    let image: String?
}

extension ResultsEntity {
    static let resultsMockData = [CharactersEntity(image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")]
}

let mockURL = "https://rickandmortyapi.com/api/character/?page=1"
