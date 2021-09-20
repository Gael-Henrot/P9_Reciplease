//
//  RecipeTableViewController.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 13/09/2021.
//

import UIKit

class RecipeViewController: UITableViewController {
    let networkService = NetworkService()
    var ingredientsList = [String]()
    var recipesList = [RecipeData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.fetchRecipes(with: ingredientsList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let recipeDataList):
                self.recipesList = recipeDataList
                print("Nombre de lignes RecipeVC: \(recipeDataList.count)")
//                print(self.recipesList[0].recipeTitle)
            
            case .failure(.wrongStatusCode):
                print("Wrong status error")
            case .failure(.noRecipeData):
                print("No recipe data received")
            case .failure(.noImageData):
                print("No image data received")
            case .failure(.noRecipeFound):
                print("No recipe found")
            }
            self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesList[indexPath.row]
        var image: Data
        var rank: String
        var time: String
        
        if let backgroundImageUnwrapped = recipe.recipeImage {
            image = backgroundImageUnwrapped
        } else {
            image = (UIImage(named: "Recipe Default Image")?.pngData())!
        }
        
        if let rankUnwrapped = recipe.rank {
            rank = rankUnwrapped
        } else {
            rank = "No rank"
        }
        
        if let timeUnwrapped = recipe.executionTime, timeUnwrapped != "0" {
            time = timeUnwrapped
        } else {
            time = "No time"
        }
        cell.configure(title: recipe.recipeTitle, backgroundImage: image, ingredientsList: recipe.ingredientsList, rank: rank, time: time)
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
