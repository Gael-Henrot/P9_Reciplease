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
//    private init(){}
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
    
//    func allFavoriteRecipes() -> [FavoriteRecipe]? {
//            let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
//            let results = try? managedObjectContext.fetch(request)
//            return results
//        }
    
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
        request.predicate = NSPredicate(format: "fSourceURL == %@", "\(recipe.sourceURL)")
        guard let results = try? managedObjectContext.fetch(request) else {
            return
        }
        guard results.isEmpty == false else { return }
        let recipeToDelete = results[0]
        coreDataStack.mainContext.delete(recipeToDelete)
    }
//    private func removeTheRecipe(recipe: RecipeProtocol) {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
//        request.predicate = NSPredicate(format: "fTitle == %@", "\(recipe.title)")
//        request.predicate = NSPredicate(format: "fSourceURL == %@", "\(recipe.sourceURL)")
//
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
//
//        do {
//            try managedObjectContext.execute(batchDeleteRequest)
//        } catch {
//            print("The recipe cannot be deleted.")
//        }
//    }
    
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
