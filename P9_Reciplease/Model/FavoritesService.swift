//
//  FavoritesService.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation

class FavoritesService {
    static var shared = FavoritesService()
    
    private init(){}
    
    private(set) var recipes = [RecipeData]()
    
//    func add(recipe: RecipeData) {
//        if recipes.contains(where: recipe.recipeTitle) {
//            return
//        } else {
//        recipes.append(recipe)
//        }
//    }
}
