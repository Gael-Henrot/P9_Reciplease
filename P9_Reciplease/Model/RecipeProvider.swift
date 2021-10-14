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
        guard let url = bundle.url(forResource: "APIKeys", withExtension: "json") else {
            print("No API key found. Please create your APIKeys.json file.")
            return "No-API-key-found"
        }
        let data = try? Data(contentsOf: url)
        guard let APIKeys = try? JSONDecoder().decode(APIKeys.self, from: data!) else {
            print("No API key found. Please verify your APIKeys.json file content.")
            return "No-API-key-found"
        }
        return APIKeys.edanamAPIKey
    }
    
    private var nextPageURL: String = "https://api.edamam.com/api/recipes/v2"
    var isLoadingRecipes: Bool = false
    
    //MARK: - Initializer
    init(client: NetworkClientType = NetworkClient()) {
        self.client = client
    }
    
    //MARK: - Methods
    /// Asks for a list of recipe from the API Edanam and provides an array of RecipeData.
    func fetchRecipes(firstcall: Bool = true, with ingredientsList: [String]? = nil, loading: Bool = false, completionHandler: @escaping (Result<[Recipe], RecipeError>) -> Void) {
 
        if loading {
            self.isLoadingRecipes = true
        }
        
        var recipesList: [Recipe] = []
        
        var url: String {
            get {
                if firstcall {
                    return "https://api.edamam.com/api/recipes/v2"
                } else {
                    return nextPageURL
                }
            }
        }
        
        var q: String = ""
        if let ingredientsList = ingredientsList {
            for eachIngredient in ingredientsList {
                q.append("\(eachIngredient),")
            }
        }
        
        var parameters: [String: String]? {
            get {
                if firstcall {
                    return ["type": "public", "q": q, "app_id": "8e985d0c", "app_key": self.edanamAPIKey]
                } else {
                    return nil
                }
            }
        }
        print("Parameters: " + q)
        
        client.makeRequest(for: url, withMethod: .get, parameters: parameters, callback: { [weak self] (response: Result<RecipeList, NetworkError>) in
            guard self != nil else { return }
            switch response {
            case .failure(NetworkError.requestError):
                self?.isLoadingRecipes = false
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.noData):
                self?.isLoadingRecipes = false
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.wrongStatusCode):
                self?.isLoadingRecipes = false
                return completionHandler(.failure(.noRecipeFound))
            case .failure(.decodingIssue):
                self?.isLoadingRecipes = false
                return completionHandler(.failure(.noRecipeFound))
            case .success(let recipeList):
                guard let list = recipeList.recipesList, list.isEmpty == false else {
                    self?.isLoadingRecipes = false
                    return completionHandler(.failure(.noRecipeFound))
                }
                for eachRecipe in list {
                    guard let recipe = eachRecipe.recipe else {
                        self?.isLoadingRecipes = false
                        return completionHandler(.failure(.noRecipeFound))
                    }
                    guard let nextPageURL = recipeList.links?.next?.href else { return }
                    self?.nextPageURL = nextPageURL
                    recipesList.append(recipe)
                }
                completionHandler(.success(recipesList))
                if loading {
                    self?.isLoadingRecipes = false
                }
            }
            
        })
    }
}

enum RecipeError: Error {
    case noRecipeFound
}
