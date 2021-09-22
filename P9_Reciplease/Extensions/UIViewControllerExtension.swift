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
            presentAlert(title: "No recipe found!", message: "No recipe found with the ingredients provided, please try other ingredients.")
        }
    }
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    enum ErrorType {
        case noIngredientProvided, requestError, noRecipeFound
    }
}
