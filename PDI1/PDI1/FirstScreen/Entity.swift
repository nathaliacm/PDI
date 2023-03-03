//
//  Entity.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 17/02/23.
//


public struct Entity: Codable, Hashable {
    let characters: String
}

extension Entity {
    static let entityMockData = Entity(characters: "https://rickandmortyapi.com/api/character")
}
