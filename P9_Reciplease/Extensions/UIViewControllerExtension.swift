//
//  UIViewControllerExtension.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 21/09/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func presentSpecificAlert(error: ErrorType) {
        switch error {
        case .noIngredientProvided:
            presentAlert(title: "No ingredient provided!", message: "Please choose at least one ingredient before launch search.")
        case .requestError:
            presentAlert(title: "Error", message: "A problem has occured during the search, please verify your internet connexion.")
        case .noRecipeFound:
            presentAlert(title: "No recipe found!", message: "No recipe found with the ingredients provided, please try other ingredients.", shouldReturn: true)
        case .noMoreRecipes:
            presentAlert(title: "No more recipe found!", message: "No other recipes were found with the current search criteria...")
        }
    }
    
    private func presentAlert(title: String, message: String, shouldReturn: Bool = false) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let simpleAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let returnAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        if shouldReturn {
            alertVC.addAction(returnAction)
        } else {
            alertVC.addAction(simpleAction)
        }
        present(alertVC, animated: true, completion: nil)
    }
    
    enum ErrorType {
        case noIngredientProvided, requestError, noRecipeFound, noMoreRecipes
    }
}
