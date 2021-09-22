//
//  RecipeData.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 15/09/2021.
//

import Foundation
import UIKit

// This is the condensed data model structure needed by the application.

struct RecipeData {
    let recipeTitle: String
    let recipeImage: Data
    let ingredientsList: [String]
    let detailedIngredientsList: [String]
    let executionTime: String
    let rank: String
    let originSourceURL: String
}
