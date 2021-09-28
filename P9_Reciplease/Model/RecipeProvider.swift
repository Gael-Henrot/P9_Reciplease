//
//  RecipeProvider.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 24/09/2021.
//

import Foundation

class RecipeProvider {
    //MARK: - Properties
    let client: NetworkClientType
    
    /// Allows to decode the edanamAPIKey from the APIKeys.json file.
    private var edanamAPIKey: String {
        let bundle = Bundle(for: RecipeProvider.self)
        let url = bundle.url(forResource: "APIKeys", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        guard let APIKeys = try? JSONDecoder().decode(APIKeys.self, from: data!) else {
            print("No API key found. Please verify or create your APIKeys.json file.")
            return "No-API-key-found"
        }
        return APIKeys.edanamAPIKey
    }
    
    //MARK: - Initializer
    init(client: NetworkClientType = NetworkClient()) {
        self.client = client
    }
    
    //MARK: - Methods
    func fetchRecipe(with ingredientsList: [String], completionHandler: @escaping (Result<[RecipeData], RecipeError>) -> Void) {
        
        var recipesList: [RecipeData] = []
        
        guard let url = URL(string: "https://api.edamam.com/api/recipes/v2") else {
            print("Edanam API url not recognized.")
            return
        }
        
        var q: String = ""
        for eachIngredient in ingredientsList {
            q.append("\(eachIngredient),")
        }
        print("Parameters: " + q)
        
        let parameters: [String: String] = ["type": "public", "q": q, "app_id": "8e985d0c", "app_key": self.edanamAPIKey]
        
        client.makeRequest(for: url, withMethod: .get, parameters: parameters, callback: { [weak self] (response: Result<RecipeList, NetworkError>) in
            guard self != nil else { return }
            switch response {
            case .failure(NetworkError.requestError):
                print("Request error")
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.noData):
                print("No data provided")
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.wrongStatusCode):
                print("Wrong status code")
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.decodingIssue):
                print("Trouble with decodable")
                return completionHandler(.failure(.noRecipeFound))
            case .success(let recipeList):
                guard let list = recipeList.recipesList, list.isEmpty == false else {
                    return completionHandler(.failure(.noRecipeFound))
                }
                for eachRecipe in list {
                    guard let recipe = eachRecipe.recipe else {
                        return completionHandler(.failure(.noRecipeFound))
                    }
                    
                    let recipeData = RecipeData(recipeTitle: recipe.recipetitle, recipeImageURLString: recipe.recipeImageURLString, recipeImageData: recipe.recipeImageData, ingredientsList: recipe.ingredientsList, detailedIngredientsList: recipe.detailedIngredientsList, executionTime: recipe.executionTime, rank: recipe.rank, originSourceURL: recipe.originSourceURL)
                    recipesList.append(recipeData)
                }
                print("Recipes found: \(recipesList.count)")
                completionHandler(.success(recipesList))
            }
        })
        
    }
    /// Asks for a list of recipe from the API Edanam and provides an array of RecipeData.
    func fetchRecipes(with ingredientsList: [String], completionHandler: @escaping (Result<[RecipeData], RecipeError>) -> Void) {
        
        var recipesList: [RecipeData] = []
        
        client.fetchRecipeData(with: ingredientsList) { [weak self] response in
            guard self != nil else { return }
            switch response {
            case .failure(.requestError):
                print("Request error")
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.noData):
                print("No data provided")
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.wrongStatusCode):
                print("Wrong status code")
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.decodingIssue):
                print("Trouble with decodable")
                return completionHandler(.failure(.noRecipeFound))
            case .success(let recipeList):
                guard let list = recipeList.recipesList, list.isEmpty == false else {
                    return completionHandler(.failure(.noRecipeFound))
                }
                for eachRecipe in list {
                    guard let recipe = eachRecipe.recipe else {
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
}

enum RecipeError: Error {
    case noRecipeFound
}
