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
    
    var selectedRecipe: RecipeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedRecipeUnwrapped = selectedRecipe else {
            print("No recipe selected")
            return
        }
        configureDetailsView(with: selectedRecipeUnwrapped)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(tappedFavoriteButton))
    }
   
    
    
    /// Open the default web browser to see the recipe source website when the Get directions button is tapped.
    @IBAction func tappedGetDirectionsButton() {
        if let selectedRecipeUnwrapped = selectedRecipe, let url = URL(string: selectedRecipeUnwrapped.originSourceURL),
                UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
        } else {
            print("The original source of this recipe may not be showned...")
        }
    }
    
    private func configureDetailsView(with recipe: RecipeData) {
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
    
    @objc private func tappedFavoriteButton() {
        print("Appui sur bouton favori")
    }
}
