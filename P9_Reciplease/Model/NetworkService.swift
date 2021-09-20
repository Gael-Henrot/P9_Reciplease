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
                print("Status code: \(response.response!.statusCode)")
                guard response.response?.statusCode == 200 else {
                    return completionHandler(.failure(.wrongStatusCode))
                }
                guard let recipeList = response.value else {
                    return completionHandler(.failure(.noRecipeData)) }
//                var imageDatas:Data?
                for eachRecipe in recipeList.hits {
                    let imageData = eachRecipe.recipe.image.data
                    guard let image = imageData else {
                        return completionHandler(.failure(.noImageData))
                    }
//                    self.getRecipeImage(from: eachRecipe.recipe.image) { response in
//                        switch response {
//                        case .success(let imageData):
//                            imageDatas = imageData
//                        case .failure(.noImageData):
//                            return completionHandler(.failure(.noImageData))
//                        }

                            
                            let recipeData = RecipeData(recipeTitle: eachRecipe.recipe.label, recipeImage: image, ingredientsList: [], detailedIngredientsList: eachRecipe.recipe.ingredientLines, executionTime: String(eachRecipe.recipe.totalTime), rank: nil, originalSourceURL: eachRecipe.recipe.url)
                            recipesList.append(recipeData)
//                        }
                }
                guard !recipesList.isEmpty else {
                    return completionHandler(.failure(.noRecipeFound))
                }
                print("Nombre de recettes trouvées: \(recipesList.count)")
                completionHandler(.success(recipesList))
            }
    }
    
//    private func getRecipeImage(from url: String, completionHandler: @escaping (Result<Data, ImageError>) -> Void) {
//        AF.request(url, method: .get)
//            .validate()
//            .responseData() { response in
//                print(url)
//                print("Status code image: \(response.response!.statusCode)")
//                guard let imageData = response.value else
//                { return completionHandler(.failure(.noImageData)) }
//                return completionHandler(.success(imageData))
//            }
//    }
}

/// Allows to decode the edanamAPIKey from the APIKeys.json file.
extension NetworkService {
    private static var edanamAPIKey: String {
        let bundle = Bundle(for: NetworkService.self)
        let url = bundle.url(forResource: "APIKeys", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let APIKeys = try? JSONDecoder().decode(APIKeys.self, from: data!)
        return APIKeys!.edanamAPIKey
    }
}

/// Lists possible errors that may occur during a network request.
enum NetworkError: Error {
    case wrongStatusCode, noRecipeData, noImageData, noRecipeFound
}
//enum ImageError: Error {
//    case noImageData
//}
