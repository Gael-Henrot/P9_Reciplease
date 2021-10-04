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
    let segueToDetailsId = "segueToDetails"
    let recipeCellId = "RecipeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recipeCellNib = UINib(nibName: recipeCellId, bundle: nil)
        tableView.register(recipeCellNib, forCellReuseIdentifier: recipeCellId)
        
        ProgressHUD.show("Loading the recipes...")
        recipeProvider.fetchRecipes(with: ingredientsList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(.noRecipeFound):
                self.presentSpecificAlert(error: .noRecipeFound)
            case .success(let recipeDataList):
                self.recipesList.append(contentsOf: recipeDataList)
                print("Recipes found RecipeVC: \(recipeDataList.count)")
                self.tableView.reloadData()
            }
//            self.tableView.reloadData()
            ProgressHUD.dismiss()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedRecipe = recipesList[indexPath.row]
            performSegue(withIdentifier: segueToDetailsId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetailsId {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.selectedRecipe = selectedRecipe
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Recipes to display: \(recipesList.count)")
        return recipesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellId, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesList[indexPath.row]
        
        cell.configure(title: recipe.title, backgroundImage: recipe.imageURL, ingredientsList: recipe.ingredientsList, rank: recipe.rank, time: recipe.executionTime)
        return cell
    }
    //MARK: - Scroll view methods
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height + 100 {
            
            guard recipeProvider.isLoadingRecipes == false else {
                return
            }
            self.tableView.tableFooterView = createActivityIndicatorInFooter()
            
            recipeProvider.fetchRecipes(firstcall: false, loading: true) { [weak self] result in
                guard let self = self else { return }
                self.tableView.tableFooterView = nil
                switch result {
                case .failure(.noRecipeFound):
                    self.recipeProvider.isLoadingRecipes = false
                    print("No recipe provided")
                    self.presentSpecificAlert(error: .noRecipeFound)
                case .success(let recipeDataList):
                    self.recipesList.append(contentsOf: recipeDataList)
                    print("Recipes found in RecipeVC: \(recipeDataList.count)")
                    self.tableView.reloadData()
                
                }
            }
            print("Recipe in recipesListVC: \(recipesList.count)")
        }
    }
    
    private func createActivityIndicatorInFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return footerView
    }
}
