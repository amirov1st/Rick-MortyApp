//
//  NetworkManager.swift
//  Heroes
//
//  Created by Amirov Foma on 13.05.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case url = "https://rickandmortyapi.com/api/character"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchImage(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchCharacters(url: String, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        guard let url = URL(string: url) else { completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else { completion(.failure(.noData))
                return }
            
            do {
                let decoder = JSONDecoder()
                let charactersQuery = try decoder.decode(CharactersQuery.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(charactersQuery.results))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    private init() {}
}
