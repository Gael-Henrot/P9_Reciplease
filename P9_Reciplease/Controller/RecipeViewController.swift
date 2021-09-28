//
//  RecipeTableViewController.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 13/09/2021.
//

import UIKit
import ProgressHUD

class RecipeViewController: UITableViewController {
    
    let recipeProvider = RecipeProvider()
    var ingredientsList = [String]()
    var recipesList = [RecipeData]()
    var selectedRecipe: RecipeData?

    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show("Loading the recipes...")
        recipeProvider.fetchRecipes(with: ingredientsList) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case .failure(.noRecipeFound):
                self.presentSpecificAlert(error: .noRecipeFound)
            case .success(let recipeDataList):
                self.recipesList = recipeDataList
                print("Nombre de lignes RecipeVC: \(recipeDataList.count)")
            
            }
            self.tableView.reloadData()
            ProgressHUD.dismiss()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedRecipe = recipesList[indexPath.row]
            performSegue(withIdentifier: "segueToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.selectedRecipe = selectedRecipe
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesList[indexPath.row]
        cell.configure(title: recipe.title, backgroundImage: recipe.recipeImageData, ingredientsList: recipe.ingredientsList, rank: recipe.rank, time: recipe.executionTime)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
}
