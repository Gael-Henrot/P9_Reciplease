//
//  Ingredient.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 07/09/2021.
//

import Foundation

class IngredientService {
    
    static var shared = IngredientService()
    
    private init(){}
    
    private(set) var ingredients = [String]()
    
    func add(ingredient: String) {
        guard ingredient != "" && !ingredient.contains(" ") else {
            return
        }
        if ingredients.contains(ingredient) {
            return
        } else {
        ingredients.append(ingredient)
        }
    }
    func removeAllIngredients() {
        ingredients.removeAll()
    }
}
