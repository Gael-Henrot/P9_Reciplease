//
//  RecipeData.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 15/09/2021.
//

import Foundation

// This is the condensed data model structure needed by the application.

struct RecipeData: Equatable {
    let recipeTitle: String
    let recipeImageURLString: String
    let recipeImageData: Data
    let ingredientsList: [String]
    let detailedIngredientsList: [String]
    let executionTime: String
    let rank: String
    let originSourceURL: String
}
