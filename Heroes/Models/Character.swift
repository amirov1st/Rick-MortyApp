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
    
    var description: String {
        """
        ID: \(id)
        Name: \(name)
        Species: \(species)
        Gender: \(gender)
        This character is from \(origin.name) planet. At the moment lives at \(location.name).
        """
    }
}

struct Origin: Decodable {
    let name: String
}
