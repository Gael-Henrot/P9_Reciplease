//
//  FavoritesManager.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation

class FavoritesManager {
    static var shared = FavoritesManager()
    
    private init(){}
    
    private(set) var recipes = [RecipeData]()
    
    /// Manages the recipe in the FavoritesManager recipes list: if the recipe is not in the list, the method will put the recipe in the list. If the recipe is already in the list, the method will remove it.
    /// - Parameter recipe: the recipe to manage.
    func managesFavoriteRecipe(recipe: RecipeData) {
        if recipe.isAFavorite == false {
            add(recipe: recipe)
        } else {
            remove(recipe: recipe)
        }
    }
    
    private func add(recipe: RecipeData) {
        print("The recipe is added to favorite list.")
        recipes.append(recipe)
    }
    
    private func remove(recipe: RecipeData) {
        guard let index = recipes.firstIndex(of: recipe) else {
            print("The recipe is already not in favorite recipes list...")
            return
        }
        recipes.remove(at: index)
        print("The recipe is removed from favorite list.")
    }
}
