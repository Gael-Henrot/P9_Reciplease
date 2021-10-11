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
    let recipesList: [RecipeDetails]?

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
    let ingredients: [Ingredient]?
    let totalTime: Double?
}


// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, image
    }
}

// MARK: - RecipeListLinks
struct RecipeListLinks: Codable {
    let next: Next?
}

extension Recipe: RecipeProtocol, Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        if lhs.title == rhs.title && lhs.sourceURL == rhs.sourceURL {
            return true
        } else {
            return false
        }
    }
    
    var title: String {
        return label ?? "No title."
    }
    
    var imageURL: String {
        return image ?? "No image."
    }
    
    var ingredientsList: [String] {
        var list = [String]()
        guard let ingredients = self.ingredients else { return ["No ingredient."] }
        for each in ingredients {
            guard let description = each.food else { return ["No ingredient."] }
            list.append(description)
        }
        return list
    }
    
    var detailedIngredientsList: [String] {
        return ingredientLines ?? ["No ingredient."]
    }
    
    var executionTime: String {
        if let executionTime = totalTime, totalTime != 0 {
            return "\(String(executionTime)) min."
        } else {
            return "No time."
        }
    }
    
    var rank: String {
        return "No rank."
    }
    
    var sourceURL: String {
        return url ?? "No source URL."
    }
}
