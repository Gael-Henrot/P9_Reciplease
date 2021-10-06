//
//  RecipeProtocol.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation

protocol RecipeProtocol {
    var title: String { get }
    var imageURL: String { get }
    var ingredientsList: [String] { get }
    var detailedIngredientsList: [String] { get }
    var executionTime: String { get }
    var rank: String { get }
    var sourceURL: String { get }
}

extension RecipeProtocol {
    var isAFavorite: Bool {
        get {
            if FavoriteRecipe.all.contains(where: { favoriteRecipe in
                            return (favoriteRecipe.title == self.title) && (favoriteRecipe.sourceURL == self.sourceURL)
                        }) {
                return true
            } else {
                return false
            }
        }
    }
}
