//
//  IngredientViewController.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 07/09/2021.
//

import UIKit

class IngredientViewController: UIViewController {
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    let initialAdvice: String = "Add a new ingredient in the list to begin the search. No need to use plural."
    var ingredientListToDisplay: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextView.text = initialAdvice
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedAddButton() {
        addAnIngredient()
        refreshIngredientTextView()
    }
    
    @IBAction func tappedClearButton() {
        IngredientService.shared.removeAllIngredients()
        refreshIngredientTextView()
    }
    
    @IBAction func tappedSearchButton() {
    }
    
    private func addAnIngredient() {
        guard let ingredient = ingredientTextField.text else { return }
        IngredientService.shared.add(ingredient: ingredient)
    }
    
    private func refreshIngredientTextView() {
        ingredientListToDisplay.removeAll()
        for ingredient in IngredientService.shared.ingredients {
            ingredientListToDisplay.append("- \(ingredient)\n")
        }
        if IngredientService.shared.ingredients.isEmpty {
            ingredientsTextView.text = initialAdvice
        } else {
            ingredientsTextView.text = ingredientListToDisplay
        }
        print(IngredientService.shared.ingredients)
        print(ingredientListToDisplay)
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
