//
//  RecipeList.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 13/09/2021.
//

import Foundation
import UIKit

// This is all the data model structures provided by the edanam API.

// MARK: - RecipeList
struct RecipeList: Codable {
    
    let from, to, count: Int?
    let links: RecipeListLinks?
    let recipesList: [RecipeDetails?]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case recipesList = "hits"
    }
}

// MARK: - RecipeDetails
struct RecipeDetails: Codable {
    let recipe: Recipe?
    let links: RecipeLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - RecipeLinks
struct RecipeLinks: Codable {
    let linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String?
}

// MARK: - Recipe
struct Recipe: Codable {
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let ingredientLines: [String]?
    let ingredients: [Ingredient?]
    let totalTime: Int?
}


// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let weight: Double?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, weight, image
    }
}

// MARK: - RecipeListLinks
struct RecipeListLinks: Codable {
    let next: Next?
}

// Allows to easily convert the API result into a value or a default value if the value does not exist.
extension Recipe {
    var title: String {
        get {
            if let title = label {
                return title
            } else {
                return "No title"
            }
        }
    }
    
    var recipeImage: String {
        get {
            if let image = image {
                return image
            } else {
            return "No image found."
            }
        }
    }
    var recipeImageData: Data {
        get {
            if let recipeImageData = recipeImage.data {
                return recipeImageData
            } else {
                guard let imageData = UIImage(named: "Recipe Default Image")?.pngData() else {
                    print("Default image not found.")
                    return Data()
                }
                return imageData
            }
        }
    }
    var ingredientsList: [String] {
        get {
            if let ingredientsList = ingredientLines {
                return ingredientsList
            } else {
            return ["No ingredient provided."]
            }
        }
    }
    var detailedIngredientsList: [String] {
        get {
            if let DetailedIngredientsList = ingredientLines {
                return DetailedIngredientsList
            } else {
            return ["No ingredient provided."]
            }
        }
    }
    var executionTime: String {
        get {
            if let executionTime = totalTime, totalTime != 0 {
                return "\(String(executionTime)) min."
            } else {
            return "No time."
            }
        }
    }
    var rank: String {
        get {
            return "No rank."
            }
    }
    var originSourceURL: String {
        get {
            if let originSourceURL = url {
                return originSourceURL
            } else {
            return "No source provided"
            }
        }
    }
}
