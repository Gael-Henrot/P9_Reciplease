//
//  NetworkService.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 08/09/2021.
//

import Foundation
import Alamofire

class NetworkService {
    
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
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: RecipeList.self) { response in
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

                                        let recipeData = RecipeData(recipeTitle: recipe.title, recipeImage: recipe.recipeImageData, ingredientsList: recipe.ingredientsList, detailedIngredientsList: recipe.detailedIngredientsList, executionTime: recipe.executionTime, rank: recipe.rank, originSourceURL: recipe.originSourceURL)
                                        recipesList.append(recipeData)
                                    }
                                    guard !recipesList.isEmpty else {
                                        return completionHandler(.failure(.noRecipeFound))
                                    }
                                    print("Nombre de recettes trouvées: \(recipesList.count)")
                                    completionHandler(.success(recipesList))
                                }
//                guard response.error == nil else {
//                    return completionHandler(.failure(.requestError))
//                }
//                print("Status code: \(response.response!.statusCode)")
//                guard response.response?.statusCode == 200 else {
//                    return completionHandler(.failure(.wrongStatusCode))
//                }
//                guard let recipeList = response.value else {
//                    return completionHandler(.failure(.noRecipeData)) }
//                guard !recipeList.recipesList.isEmpty else {
//                    return completionHandler(.failure(.noRecipeFound))
//                }
//                for eachRecipe in recipeList.recipesList {
//                    guard let recipe = eachRecipe?.recipe else {
//                        return completionHandler(.failure(.noRecipeFound))
//                    }
//                    //                    guard let imageData = recipe.image?.data else {
//                    //                        return
//                    //                    }
//
//                    let recipeData = RecipeData(recipeTitle: recipe.title, recipeImage: recipe.recipeImageData, ingredientsList: recipe.ingredientsList, detailedIngredientsList: recipe.detailedIngredientsList, executionTime: recipe.executionTime, rank: recipe.rank, originSourceURL: recipe.originSourceURL)
//                    recipesList.append(recipeData)
//                }
//                guard !recipesList.isEmpty else {
//                    return completionHandler(.failure(.noRecipeFound))
//                }
//                print("Nombre de recettes trouvées: \(recipesList.count)")
//                completionHandler(.success(recipesList))
            }
    }
}

/// Allows to decode the edanamAPIKey from the APIKeys.json file.
extension NetworkService {
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
    case wrongStatusCode, requestError, noRecipeData, noImageData, noRecipeFound
}
