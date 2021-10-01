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
    
    func isAFavoriteRecipe(recipe: RecipeData) -> Bool {
        if recipes.contains(recipe) {
            return true
        } else {
            return false
        }
    }
    
    func managesFavoriteRecipe(recipe: RecipeData) {
        if isAFavoriteRecipe(recipe: recipe) == false {
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
