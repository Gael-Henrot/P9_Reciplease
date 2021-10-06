//
//  FavoritesManagerTestCases.swift
//  P9_RecipleaseTests
//
//  Created by Gaël HENROT on 04/10/2021.
//

import XCTest
@testable import P9_Reciplease

class FavoritesManagerTestCases: XCTestCase {
    let recipe = RecipeData(title: "Recipe1", imageURL: "URL-of-Image", ingredientsList: ["Ingredient1", "Ingredient2"], detailedIngredientsList: ["Detailed Ingredient1", "Detailed Ingredient2"], executionTime: "10", rank: "No rank.", sourceURL: "URL-of-Source")
    
//    func testGivenTheFavoritesListIsEmpty_WhenARecipeIsManaged_ThenTheRecipeIsAddToFavoriteList() {
//        FavoritesManager.shared.managesFavoriteRecipe(recipe: recipe)
//        XCTAssertEqual(FavoritesManager.shared.recipes, [recipe])
//    }
//    
//    func testGivenTheFavoritesListContainsTheRecipe_WhenTheRecipeIsManaged_ThenTheRecipeIsRemoveToFavoriteList() {
//        FavoritesManager.shared.managesFavoriteRecipe(recipe: recipe)
//        FavoritesManager.shared.managesFavoriteRecipe(recipe: recipe)
//        XCTAssertEqual(FavoritesManager.shared.recipes, [])
//    }
}

