//
//  FavoriteRecipe.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 05/10/2021.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject, RecipeProtocol {
    var title: String {
        return fTitle ?? "No title."
    }
    
    var imageURL: String {
        return fImageURL ?? "No image."
    }
    
    var ingredientsList: [String] {
        return fIngredientsList ?? ["No ingredient."]
    }
    
    var detailedIngredientsList: [String] {
        return fDetailedIngredientsList ?? ["No ingredient."]
    }
    
    var executionTime: String {
        return fExecutionTime ?? "No time."
    }
    
    var rank: String {
        return fRank ?? "No rank."
    }
    
    var sourceURL: String {
        return fSourceURL ?? "No source URL."
    }
}
