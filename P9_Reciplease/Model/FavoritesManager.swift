//
//  FavoritesManager.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation
import CoreData

class FavoritesManager {
    
    //MARK: - Properties
//    static var shared = FavoritesManager()

    //MARK: - Initializer
//    private init(){}
    
    //MARK: - Methods
    /// Manages the recipe in the FavoritesManager recipes list: if the recipe is not in the list, the method will put the recipe in the list. If the recipe is already in the list, the method will remove it.
    /// - Parameter recipe: the recipe to manage.
    func managesFavoriteRecipe(recipe: RecipeProtocol) {
        if recipe.isAFavorite == false {
            saveTheRecipe(recipe: recipe)
            print("The recipe is added to favorite list.")
        } else {
            removeTheRecipe(recipe: recipe)
            print("The recipe is removed from favorite list.")
        }
    }
    
    private func saveTheRecipe(recipe: RecipeProtocol) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.fTitle = recipe.title
        favoriteRecipe.fImageURL = recipe.imageURL
        favoriteRecipe.fIngredientsList = recipe.ingredientsList
        favoriteRecipe.fDetailedIngredientsList = recipe.detailedIngredientsList
        favoriteRecipe.fExecutionTime = recipe.executionTime
        favoriteRecipe.fRank = recipe.rank
        favoriteRecipe.fSourceURL = recipe.sourceURL
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("The recipe cannot be saved.")
        }
        
    }
    
    private func removeTheRecipe(recipe: RecipeProtocol) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        request.predicate = NSPredicate(format: "fTitle == %@", "\(recipe.title)")
        request.predicate = NSPredicate(format: "fSourceURL == %@", "\(recipe.sourceURL)")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try AppDelegate.viewContext.execute(batchDeleteRequest)
        } catch {
            print("The recipe cannot be deleted.")
        }
    }
    
//    func recipeIsFavorite(_ recipe: RecipeProtocol) -> Bool {
//        let request = FavoriteRecipe.fetchRequest()
//        let results = AppDelegate.viewContext.fetch(request)
//        if results.contains(where: { favoriteRecipe in
//            return favoriteRecipe.sourceURL == recipe.sourceURL
//        }) {
//            return true
//        } else {
//            return false
//        }
//    }
}
