//
//  FavoriteViewController.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 04/10/2021.
//

import UIKit
import CoreData

class FavoriteViewController: UITableViewController {
    
    var selectedRecipe: RecipeProtocol?
    let segueToDetailsId = "segueFavoriteToDetails"
    let recipeCellId = "RecipeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recipeCellNib = UINib(nibName: recipeCellId, bundle: nil)
        tableView.register(recipeCellNib, forCellReuseIdentifier: recipeCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FavoriteRecipe.all.isEmpty {
            tableView.tableHeaderView = createHeader()
        } else {
            tableView.tableHeaderView = nil
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = FavoriteRecipe.all[indexPath.row]
            performSegue(withIdentifier: segueToDetailsId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetailsId {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.selectedRecipe = selectedRecipe
            detailsVC.previousVC = self
        }
    }
    
    private func createHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let adviceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        adviceLabel.backgroundColor = .brown //UIColor(displayP3Red: 55, green: 51, blue: 50, alpha: 1)
        adviceLabel.numberOfLines = 0
        adviceLabel.text = "To add a recipe in the favorites, search some recipes, select the desired recipe and tapped the star ☆ in the upper right corner."
        adviceLabel.textColor = .white
        adviceLabel.textAlignment = .center
        adviceLabel.center = headerView.center
        headerView.addSubview(adviceLabel)
        return headerView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FavoriteRecipe.all.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellId, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        let recipe = FavoriteRecipe.all[indexPath.row]
        
        cell.configure(title: recipe.title, backgroundImage: recipe.imageURL, ingredientsList: recipe.ingredientsList, rank: recipe.rank, time: recipe.executionTime)

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
