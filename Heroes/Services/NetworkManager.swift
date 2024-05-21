//
//  NetworkManager.swift
//  Heroes
//
//  Created by Amirov Foma on 13.05.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link {
    case urlApi
    
    var url: URL {
        switch self {
        case .urlApi:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchImage(url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .responseData { response in
            switch response.result {
            case .success(let imageData):
                completion(.success(imageData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func fetchCharacters(from url: URL, completion: @escaping (Result<[Character], AFError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let jsonValue):                    
                    let characters =  Character.getCharacters(from: jsonValue)
                    completion(.success(characters))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private init() {}
}
