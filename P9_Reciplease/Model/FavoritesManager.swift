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
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favorites: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let results = try? managedObjectContext.fetch(request) else {
            return []
        }
        return results
    }

    //MARK: - Initializer
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    //MARK: - Methods
    /// Manages the recipe in the FavoritesManager recipes list: if the recipe is not in the list, the method will put the recipe in the list. If the recipe is already in the list, the method will remove it.
    /// - Parameter recipe: the recipe to manage.
    func managesFavoriteRecipe(recipe: RecipeProtocol) {
        if recipeIsFavorite(recipe) == false {
            saveTheRecipe(recipe: recipe)
            print("The recipe is added to favorite list.")
        } else {
            removeTheRecipe(recipe: recipe)
            print("The recipe is removed from favorite list.")
        }
    }
    
    func recipeIsFavorite(_ recipe: RecipeProtocol) -> Bool {
            if favorites.contains(where: { favoriteRecipe in
                return favoriteRecipe.sourceURL == recipe.sourceURL
            }) {
                return true
            } else {
                return false
            }
        }
    
    private func saveTheRecipe(recipe: RecipeProtocol) {
        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.fTitle = recipe.title
        favoriteRecipe.fImageURL = recipe.imageURL
        favoriteRecipe.fIngredientsList = recipe.ingredientsList
        favoriteRecipe.fDetailedIngredientsList = recipe.detailedIngredientsList
        favoriteRecipe.fExecutionTime = recipe.executionTime
        favoriteRecipe.fRank = recipe.rank
        favoriteRecipe.fSourceURL = recipe.sourceURL
        coreDataStack.saveContext()
        
    }
    
    private func removeTheRecipe(recipe: RecipeProtocol) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "fTitle == %@", "\(recipe.title)")
        request.predicate = NSPredicate(format: "fSourceURL == %@", "\(recipe.sourceURL)")
        guard let results = try? managedObjectContext.fetch(request) else {
            return
        }
        guard results.isEmpty == false else { return }
        let recipeToDelete = results[0]
        coreDataStack.mainContext.delete(recipeToDelete)
        coreDataStack.saveContext()
    }
}
