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
    var favoritesManager: FavoritesManager?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recipeCellNib = UINib(nibName: recipeCellId, bundle: nil)
        tableView.register(recipeCellNib, forCellReuseIdentifier: recipeCellId)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        favoritesManager = FavoritesManager(coreDataStack: coreDataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if favoritesManager?.favorites == nil {
            tableView.tableHeaderView = createHeader()
        } else {
            tableView.tableHeaderView = nil
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let all = favoritesManager?.favorites else { return }
        selectedRecipe = all[indexPath.row]
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
        guard let all = favoritesManager?.favorites else { return 0 }
        return all.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellId, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        guard let all = favoritesManager?.favorites else { return UITableViewCell()}
        
        let recipe = all[indexPath.row]
        
        cell.configure(title: recipe.title, backgroundImage: recipe.imageURL, ingredientsList: recipe.ingredientsList, rank: recipe.rank, time: recipe.executionTime)

        return cell
    }
}
