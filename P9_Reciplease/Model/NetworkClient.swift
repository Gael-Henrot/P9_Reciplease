//
//  NetworkClient.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 08/09/2021.
//

import Foundation
import Alamofire

class NetworkClient: NetworkClientType {
    
    //MARK: - Methods
    func makeRequest<T: Codable>(for url: URL, withMethod method: HTTPMethod?, parameters : [String: String]?, callback: @escaping ((Result<T, NetworkError>) -> Void)) {
        AF.request(url, method: method ?? .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { [weak self] response in
                guard self != nil else { return }
                switch response.result {
                case .failure(_):
                    callback(.failure(.requestError))
                case .success(let response):
                    callback(.success(response))
                }
                
            }
    }
    func fetchRecipeData(with ingredientsList: [String], callback: @escaping (Result<RecipeList, NetworkError>) -> Void) {
        let url = "https://api.edamam.com/api/recipes/v2"
        
        var q: String = ""
        for eachIngredient in ingredientsList {
            q.append("\(eachIngredient),")
        }
        print("Parameters: " + q)
        
        let parameters: [String: String] = ["type": "public", "q": q, "app_id": "8e985d0c", "app_key": NetworkClient.edanamAPIKey]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: RecipeList.self) { [weak self] response in
                guard self != nil else { return }
                switch response.result {
                case .failure(let error):
                    switch error {
                    case .responseValidationFailed:
                        callback(.failure(.wrongStatusCode))
                    default:
                        callback(.failure(.noData))
                    }
                case.success(let recipeList):
                    callback(.success(recipeList))
                }
                
            }
    }
    
    /// Allows to decode the edanamAPIKey from the APIKeys.json file.
    private static var edanamAPIKey: String {
        let bundle = Bundle(for: NetworkClient.self)
        let url = bundle.url(forResource: "APIKeys", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        guard let APIKeys = try? JSONDecoder().decode(APIKeys.self, from: data!) else {
            print("No API key found. Please verify or create your APIKeys.json file.")
            return "No-API-key-found"
        }
        return APIKeys.edanamAPIKey
    }
}

/// Lists possible errors that may occur during a network request.
enum NetworkError: Error {
    case requestError, noData, wrongStatusCode, decodingIssue
}

protocol NetworkClientType {
    func makeRequest<T: Codable>(for url: URL, withMethod method: HTTPMethod?, parameters : [String: String]?, callback: @escaping ((Result<T, NetworkError>) -> Void))
    func fetchRecipeData(with ingredientsList: [String], callback: @escaping (Result<RecipeList, NetworkError>) -> Void)
}
