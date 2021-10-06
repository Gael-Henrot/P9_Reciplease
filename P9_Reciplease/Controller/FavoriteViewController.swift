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
}
