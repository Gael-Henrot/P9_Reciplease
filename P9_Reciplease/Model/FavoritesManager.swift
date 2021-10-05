//
//  FavoritesManager.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation
import CoreData

class FavoritesManager {
    static var shared = FavoritesManager()
    
    private init(){}
    
    private(set) var recipes = [RecipeProtocol]()
    
    /// Manages the recipe in the FavoritesManager recipes list: if the recipe is not in the list, the method will put the recipe in the list. If the recipe is already in the list, the method will remove it.
    /// - Parameter recipe: the recipe to manage.
    func managesFavoriteRecipe(recipe: RecipeProtocol) {
        if recipe.isAFavorite == false {
            add(recipe: recipe)
        } else {
            remove(recipe: recipe)
        }
    }
    
    private func add(recipe: RecipeProtocol) {
        print("The recipe is added to favorite list.")
//        recipes.append(recipe)
        saveTheRecipe(recipe: recipe)
    }
    
    private func remove(recipe: RecipeProtocol) {
//        guard let index = recipes.firstIndex(of: recipe) else {
//            print("The recipe is already not in favorite recipes list...")
//            return
//        }
//        recipes.remove(at: index)
        print("The recipe is removed from favorite list.")
        removeTheRecipe(recipe: recipe as! FavoriteRecipe)
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
        try? AppDelegate.viewContext.save()
    }
    
    private func removeTheRecipe(recipe: FavoriteRecipe) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        request.predicate = NSPredicate(format: "fTitle == %@", "\(recipe.title)")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try AppDelegate.viewContext.execute(batchDeleteRequest)
        } catch {
            
        }
    }
}
