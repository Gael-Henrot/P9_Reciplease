//
//  IngredientViewController.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 07/09/2021.
//

import UIKit

class IngredientViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    let initialAdvice: String = "Add a new ingredient in the list to begin the search. \nNo need to use plural."
    var ingredientsListToDisplay: String = ""
    var ingredientsList = [String]()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextView.text = initialAdvice
    }
    
    @IBAction func tappedAddButton() {
        addAnIngredient()
        refreshIngredientTextView()
        ingredientTextField.text = nil
    }
    
    @IBAction func tappedClearButton() {
        ingredientsList.removeAll()
        refreshIngredientTextView()
    }
    
    @IBAction func tappedSearchButton() {
        guard !ingredientsList.isEmpty else {
            presentSpecificAlert(error: .noIngredientProvided)
            return
        }
        performSegue(withIdentifier: "segueToRecipesResearchResult", sender: nil)
    }
    
    private func addAnIngredient() {
        guard let ingredient = ingredientTextField.text, ingredient != "" else { return }
       
        if ingredientsList.contains(ingredient) {
            return
        } else {
        ingredientsList.append(ingredient)
        }
    }
    
    private func refreshIngredientTextView() {
        ingredientsListToDisplay.removeAll()
        for ingredient in ingredientsList {
            ingredientsListToDisplay.append("- \(ingredient)\n")
        }
        if ingredientsList.isEmpty {
            ingredientsTextView.text = initialAdvice
        } else {
            ingredientsTextView.text = ingredientsListToDisplay
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipesResearchResult" {
            let recipesResearchResultVC = segue.destination as! RecipeViewController
            recipesResearchResultVC.ingredientsList = ingredientsList
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
