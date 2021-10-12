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
    let recipe = Recipe(label: "Recipe1", image: "URL-of-Image", source: "Source Website", url: "URL-of-Source", ingredientLines: ["Ingredient1", "Ingredient2"], ingredients: [Ingredient(text: "Ingredient1", quantity: 1.0, measure: nil, food: "Detailed Ingredient1", weight: nil, image: nil), Ingredient(text: "Ingredient2", quantity: 1.0, measure: nil, food: "Detailed Ingredient2", weight: nil, image: nil)], totalTime: 10.0)
    
    //MARK: - Tests Life Cycle
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
    
    //MARK: - Tests
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
    
    func testGivenTheFavoritesContainsTheRecipe_WhenRecipeIsFavoriteIsCalled_ThenTheMethodShouldReturnTrue() {
        favoritesManager.managesFavoriteRecipe(recipe: recipe)
        let favorite = favoritesManager.recipeIsFavorite(recipe)
        XCTAssertTrue(favorite)
    }
    
    func testGivenTheFavoritesDoNotContainsTheRecipe_WhenRecipeIsFavoriteIsCalled_ThenTheMethodShouldReturnFalse() {
        let favorite = favoritesManager.recipeIsFavorite(recipe)
        XCTAssertFalse(favorite)
    }
}
