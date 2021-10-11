//
//  FavoritesManagerTestCases.swift
//  P9_RecipleaseTests
//
//  Created by Gaël HENROT on 04/10/2021.
//

import XCTest
@testable import P9_Reciplease

class FavoritesManagerTestCases: XCTestCase {
    
    //MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var favoritesManager: FavoritesManager!
    let recipe = RecipeData(title: "Recipe1", imageURL: "URL-of-Image", ingredientsList: ["Ingredient1", "Ingredient2"], detailedIngredientsList: ["Detailed Ingredient1", "Detailed Ingredient2"], executionTime: "10", rank: "No rank.", sourceURL: "URL-of-Source")
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        favoritesManager = FavoritesManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        favoritesManager = nil
        coreDataStack = nil
    }
    
    func testGivenTheFavoritesAreEmpty_WhenARecipeIsManagedInFavorites_ThenTheRecipeIsAddedToFavorites() {
        favoritesManager.managesFavoriteRecipe(recipe: recipe)
        XCTAssert(favoritesManager.favorites.isEmpty == false)
        XCTAssert(favoritesManager.favorites[0].title == "Recipe1")
        
    }
    
    func testGivenTheFavoritesContainsTheRecipe_WhenTheRecipeIsManagedInFavorites_ThenTheRecipeIsRemovedFromFavorites() {
        favoritesManager.managesFavoriteRecipe(recipe: recipe)
        favoritesManager.managesFavoriteRecipe(recipe: recipe)
        XCTAssert(favoritesManager.favorites.isEmpty == true)
        
    }
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

