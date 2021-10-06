//
//  DetailsViewController.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 20/09/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var detailedIngredientsListLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedRecipe: RecipeProtocol?
    var previousVC: UIViewController?
    let favoritesManager = FavoritesManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let selectedRecipeUnwrapped = selectedRecipe else {
            print("No recipe selected")
            return
        }
        configureDetailsView(with: selectedRecipeUnwrapped)
        
        // Creation of favoriteButton
        let favoriteButton = FavoriteButton(image: UIImage(systemName: "star"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.tappedFavoriteButton(_:)))
        favoriteButton.tintColor = .green
        navigationItem.rightBarButtonItem = favoriteButton
        
        // Initialization of favoriteButton
        if selectedRecipeUnwrapped.isAFavorite {
            favoriteButton.isFavorite = true
        } else {
            favoriteButton.isFavorite = false
        }
    }
   
    
    /// Open the default web browser to see the recipe source website when the "Get directions button" is tapped.
    @IBAction func tappedGetDirectionsButton() {
        if let selectedRecipeUnwrapped = selectedRecipe, let url = URL(string: selectedRecipeUnwrapped.sourceURL),
                UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
        } else {
            print("The original source of this recipe may not be showned...")
        }
    }
    
    private func configureDetailsView(with recipe: RecipeProtocol) {
        var ingredientsListToDisplay: String = ""
        recipeImage.sd_setImage(with: URL(string: recipe.imageURL), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        recipeTitleLabel.text = recipe.title
        rankLabel.text = recipe.rank
        timeLabel.text = recipe.executionTime
        
        for ingredient in recipe.detailedIngredientsList {
            ingredientsListToDisplay.append("- \(ingredient)\n")
        }
        detailedIngredientsListLabel.text = ingredientsListToDisplay
    }

    @objc private func tappedFavoriteButton(_ sender:FavoriteButton!) {
        guard let selectedRecipe = selectedRecipe else {
            return
        }
        if sender.isFavorite == false {
            sender.isFavorite = true
        } else {
            sender.isFavorite = false
        }
        favoritesManager.managesFavoriteRecipe(recipe: selectedRecipe)
        if previousVC is FavoriteViewController {
            navigationController?.popViewController(animated: true)
        }
    }
}
