//
//  Character.swift
//  Heroes
//
//  Created by Amirov Foma on 13.05.2024.
//

struct CharactersQuery: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Origin
    let image: String
}

struct Origin: Decodable {
    let name: String
}
