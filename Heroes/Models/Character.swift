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
    
    init(value: [String: Any]) {
        id = value["id"] as? Int ?? 0
        name = value["name"] as? String ?? ""
        species = value["species"] as? String ?? ""
        gender = value["gender"] as? String ?? ""
        origin = Origin(value: value["origin"] as? [String : String] ?? [:])
        location = Origin(value: value["location"] as? [String: String] ?? [:])
        image = value["image"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let value = value as? [String: Any] else { return [] }
        guard let results = value["results"] as? [[String: Any]] else { return [] }
        var characters = [Character]()
        
        for result in results {
            let character = Character(value: result)
            characters.append(character)
        }
        
        return characters
    }
}

struct Origin: Decodable {
    let name: String
    
    init(value: [String: String]) {
        name = value["name"] ?? ""
    }
}
