//
//  FakeResponse.swift
//  P9_RecipleaseTests
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation
import P9_Reciplease

class FakeResponse {
    static var recipesCorrectData: Data {
        let bundle = Bundle(for: FakeResponse.self)
        let url = bundle.url(forResource: "CorrectRecipesData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let recipe1 = RecipeData(recipeTitle: "Tuna With Peppery Tomatoes & Potatoes", recipeImage: "https://www.edamam.com/web-img/e89/e89259a951e7ed764afdcc69265543a8.jpg".data!, ingredientsList: ["2 red peppers , cut into large chunks",
                             "1 red onion , cut into eighths",
                             "few thyme sprigs",
                             "400.0g can cherry tomatoes",
                             "1 green chilli , deseeded and chopped",
                             "4 tuna steaks",
                             "1.0 tbsp olive oil",
                             "500.0g bag new potatoes , sliced about 1cm thick",
                             "3 garlic cloves , crushed"], detailedIngredientsList: ["2 red peppers , cut into large chunks",
                                                                                     "1 red onion , cut into eighths",
                                                                                     "few thyme sprigs",
                                                                                     "400.0g can cherry tomatoes",
                                                                                     "1 green chilli , deseeded and chopped",
                                                                                     "4 tuna steaks",
                                                                                     "1.0 tbsp olive oil",
                                                                                     "500.0g bag new potatoes , sliced about 1cm thick",
                                                                                     "3 garlic cloves , crushed"], executionTime: "No time", rank: "No rank", originSourceURL: "http://www.bbcgoodfood.com/recipes/5876/")
    static let recipe2 = RecipeData(recipeTitle: "Mashed Tomato Potatoes", recipeImage: "https://www.edamam.com/web-img/ec2/ec2869a20b214cc7a1c91aab816b92ee.jpg".data!, ingredientsList: [
        "2 pounds Yukon Gold potatoes (about 6), peeled and cut into 2-inch pieces",
        "2 garlic cloves, peeled",
        "1/2 cup milk",
        "1/4 cup (1/2 stick) unsalted butter",
        "1/4 cup chopped flat-leaf parsley",
        "3 scallions, trimmed and chopped",
        "1/2 cup grated Parmesan",
        "1/2 teaspoon kosher salt",
        "2 pounds salad tomatoes (about 5 medium), chopped"
    ], detailedIngredientsList: [
        "2 pounds Yukon Gold potatoes (about 6), peeled and cut into 2-inch pieces",
        "2 garlic cloves, peeled",
        "1/2 cup milk",
        "1/4 cup (1/2 stick) unsalted butter",
        "1/4 cup chopped flat-leaf parsley",
        "3 scallions, trimmed and chopped",
        "1/2 cup grated Parmesan",
        "1/2 teaspoon kosher salt",
        "2 pounds salad tomatoes (about 5 medium), chopped"
    ], executionTime: "40", rank: "No rank", originSourceURL: "https://www.realsimple.com/food-recipes/browse-all-recipes/mashed-tomato-potatoes")
    
    static var fetchRecipesCorrectCompletion = [recipe1,recipe2]
}

struct RecipeData {
    let recipeTitle: String
    let recipeImage: Data
    let ingredientsList: [String]
    let detailedIngredientsList: [String]
    let executionTime: String
    let rank: String
    let originSourceURL: String
}
extension String {
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
