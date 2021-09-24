//
//  NetworkService.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 08/09/2021.
//

import Foundation
import Alamofire

class NetworkService {
    
    private let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    //MARK: - Methods
    
    /// Asks for a list of recipe from the API Edanam and provides an array of RecipeData.
    func fetchRecipes(with ingredientsList: [String], completionHandler: @escaping (Result<[RecipeData], NetworkError>) -> Void) {
        let url = "https://api.edamam.com/api/recipes/v2"
        
        var q: String = ""
        for eachIngredient in ingredientsList {
            q.append("\(eachIngredient),")
        }
        print("Parameters: " + q)
        
        let parameters: [String: String] = ["type": "public", "q": q, "app_id": "8e985d0c", "app_key": NetworkService.edanamAPIKey]
        
        var recipesList: [RecipeData] = []
        
        
        session.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: RecipeList.self) { [weak self] response in
                guard self != nil else { return }
                switch response.result {
                case .failure(_):
                    completionHandler(.failure(.noRecipeFound))
                    //                                    switch error {
                    //                                    case .ResponseValidationFailureReason.unacceptableStatusCode(let statusCode):
                    //
                    //                                    default:
                    //                                    }
                case .success(let recipeList):
                    guard !recipeList.recipesList.isEmpty else {
                        return completionHandler(.failure(.noRecipeFound))
                    }
                    for eachRecipe in recipeList.recipesList {
                        guard let recipe = eachRecipe?.recipe else {
                            return completionHandler(.failure(.noRecipeFound))
                        }
                        
                        let recipeData = RecipeData(recipeTitle: recipe.recipetitle, recipeImageURLString: recipe.recipeImageURLString, recipeImageData: recipe.recipeImageData, ingredientsList: recipe.ingredientsList, detailedIngredientsList: recipe.detailedIngredientsList, executionTime: recipe.executionTime, rank: recipe.rank, originSourceURL: recipe.originSourceURL)
                        recipesList.append(recipeData)
                    }
                    print("Nombre de recettes trouvées: \(recipesList.count)")
                    completionHandler(.success(recipesList))
                }
            }
    }
    
    private func fetchRecipeData(with ingredientsList: [String], callback: @escaping (Result<RecipeList, RequestError>) -> Void) {
        let url = "https://api.edamam.com/api/recipes/v2"
        
        var q: String = ""
        for eachIngredient in ingredientsList {
            q.append("\(eachIngredient),")
        }
        print("Parameters: " + q)
        
        let parameters: [String: String] = ["type": "public", "q": q, "app_id": "8e985d0c", "app_key": NetworkService.edanamAPIKey]
        
        AF.request(url, method: .get, parameters: parameters)
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
        let bundle = Bundle(for: NetworkService.self)
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
    case wrongStatusCode, requestError, noRecipeData, noRecipeFound
}

enum RequestError: Error {
    case requestError, noData, wrongStatusCode, decodableTrouble
}
