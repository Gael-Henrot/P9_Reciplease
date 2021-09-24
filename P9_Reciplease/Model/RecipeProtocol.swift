//
//  RecipeProtocol.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation

protocol RecipeProtocol {
    var recipeTitle: String { get }
    var recipeImage: Data { get }
    var ingredientsList: [String] { get }
    var detailedIngredientsList: [String] { get }
    var executionTime: String { get }
    var rank: String { get }
    var originSourceURL: String { get }
}
