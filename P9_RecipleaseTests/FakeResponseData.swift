//
//  FakeResponseData.swift
//  P9_RecipleaseTests
//
//  Created by Gaël HENROT on 23/09/2021.
//

import Foundation
@testable import P9_Reciplease

struct FakeRecipeProviderResponses {
    static let emptyRecipeList = RecipeList(from: nil, to: nil, count: nil, links: nil, recipesList: nil)
    static let emptyRecipeInRecipeList = RecipeList(from: nil, to: nil, count: nil, links: nil, recipesList: [RecipeDetails(recipe: nil, links: nil)])
    static let correctRecipeList = RecipeList(from: 1, to: 2, count: 2, links: RecipeListLinks(next: Next(href: "http://www.edamam.com/ontologies/edamam.owl#recipe_4668efe4dec0421db931bea615638039")), recipesList: [RecipeDetails(recipe: Recipe(label: "Tuna With Peppery Tomatoes & Potatoes", image: "https://www.edamam.com/web-img/e89/e89259a951e7ed764afdcc69265543a8.jpg", source: "BBC Good Food", url: "http://www.bbcgoodfood.com/recipes/5876/", ingredientLines: [
        "2 red peppers , cut into large chunks",
        "1 red onion , cut into eighths",
        "few thyme sprigs",
        "400.0g can cherry tomatoes",
        "1 green chilli , deseeded and chopped",
        "4 tuna steaks",
        "1.0 tbsp olive oil",
        "500.0g bag new potatoes , sliced about 1cm thick",
        "3 garlic cloves , crushed"], ingredients: [Ingredient(text: "2 red peppers , cut into large chunks", quantity: 2.0, measure: "<unit>", food: "red peppers", weight: 238.0, image: "https://www.edamam.com/food-img/4dc/4dc48b1a506d334b4ab6671b9d56a18f.jpeg"),Ingredient(text: "1 red onion , cut into eighths", quantity: 1.0, measure: "<unit>", food: "red onion", weight: 125.0, image: "https://www.edamam.com/food-img/205/205e6bf2399b85d34741892ef91cc603.jpg")], totalTime: 0.0), links: RecipeLinks(linksSelf: Next(href: ""))), RecipeDetails(recipe: Recipe(label: "Mashed Tomato Potatoes", image: "https://www.edamam.com/web-img/ec2/ec2869a20b214cc7a1c91aab816b92ee.jpg", source: "Real Simple", url: "https://www.realsimple.com/food-recipes/browse-all-recipes/mashed-tomato-potatoes", ingredientLines: [
            "2 pounds Yukon Gold potatoes (about 6), peeled and cut into 2-inch pieces",
            "2 garlic cloves, peeled",
            "1/2 cup milk",
            "1/4 cup (1/2 stick) unsalted butter",
            "1/4 cup chopped flat-leaf parsley",
            "3 scallions, trimmed and chopped",
            "1/2 cup grated Parmesan",
            "1/2 teaspoon kosher salt",
            "2 pounds salad tomatoes (about 5 medium), chopped"
        ], ingredients: [Ingredient(text: "2 pounds Yukon Gold potatoes (about 6), peeled and cut into 2-inch pieces", quantity: 2.0, measure: "pound", food: "Yukon Gold potatoes", weight: 907.18474, image: "https://www.edamam.com/food-img/651/6512e82417bce15c2899630c1a2799df.jpg"),Ingredient(text: "2 garlic cloves, peeled", quantity: 2.0, measure: "clove", food: "garlic", weight: 6.0, image: "https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg")], totalTime: 40.0), links: RecipeLinks(linksSelf: Next(href: "")))])

    static let correctRecipeDataArray = [RecipeData(title: "Tuna With Peppery Tomatoes & Potatoes", imageURL: "https://www.edamam.com/web-img/e89/e89259a951e7ed764afdcc69265543a8.jpg", ingredientsList: [
        "red peppers",
        "red onion"], detailedIngredientsList: [
            "2 red peppers , cut into large chunks",
            "1 red onion , cut into eighths",
            "few thyme sprigs",
            "400.0g can cherry tomatoes",
            "1 green chilli , deseeded and chopped",
            "4 tuna steaks",
            "1.0 tbsp olive oil",
            "500.0g bag new potatoes , sliced about 1cm thick",
            "3 garlic cloves , crushed"], executionTime: "No time.", rank: "No rank.", sourceURL: "http://www.bbcgoodfood.com/recipes/5876/"), RecipeData(title: "Mashed Tomato Potatoes", imageURL: "https://www.edamam.com/web-img/ec2/ec2869a20b214cc7a1c91aab816b92ee.jpg", ingredientsList: [
                "Yukon Gold potatoes",
                "garlic"], detailedIngredientsList: [
                "2 pounds Yukon Gold potatoes (about 6), peeled and cut into 2-inch pieces",
                "2 garlic cloves, peeled",
                "1/2 cup milk",
                "1/4 cup (1/2 stick) unsalted butter",
                "1/4 cup chopped flat-leaf parsley",
                "3 scallions, trimmed and chopped",
                "1/2 cup grated Parmesan",
                "1/2 teaspoon kosher salt",
                "2 pounds salad tomatoes (about 5 medium), chopped"
                ], executionTime: "40.0 min.", rank: "No rank.", sourceURL: "https://www.realsimple.com/food-recipes/browse-all-recipes/mashed-tomato-potatoes")]
}
