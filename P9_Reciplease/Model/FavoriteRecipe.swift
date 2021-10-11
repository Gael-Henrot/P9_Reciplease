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
        get {
            guard let title = fTitle else {
                return "No title"
            }
            return title
        }
    }
    
    var imageURL: String {
        get {
            guard let imageURL = fImageURL else {
                return "No image URL"
            }
            return imageURL
        }
    }
    
    var ingredientsList: [String] {
        get {
            guard let ingredientsList = fIngredientsList else {
                return ["No ingredient"]
            }
            return ingredientsList
        }
    }
    
    var detailedIngredientsList: [String] {
        get {
            guard let detailedIngredientsList = fDetailedIngredientsList else {
                return ["No ingredient"]
            }
            return detailedIngredientsList
        }
    }
    
    var executionTime: String {
        get {
            guard let executionTime = fExecutionTime else {
                return "No time."
            }
            return executionTime
        }
    }
    
    var rank: String {
        get {
            guard let rank = fRank else {
                return "No rank."
            }
            return rank
        }
    }
    
    var sourceURL: String {
        get {
            guard let sourceURL = fSourceURL else {
                return "No source URL"
            }
            return sourceURL
        }
    }
    
//    static var all: [FavoriteRecipe] {
//        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
//        guard let recipes = try? AppDelegate.viewContext.fetch(request) else {
//            return []
//        }
//        return recipes
//    }
}
