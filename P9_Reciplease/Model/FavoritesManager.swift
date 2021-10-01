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
    
    func add(recipe: RecipeData) {
        if recipes.contains(recipe) {
            return
        } else {
        recipes.append(recipe)
        }
    }
}
