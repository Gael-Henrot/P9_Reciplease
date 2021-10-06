//
//  RecipeCell.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 04/10/2021.
//

import UIKit
import Alamofire
import SDWebImage

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(title: String, backgroundImage: String, ingredientsList: [String], rank: String, time: String) {
        recipeImage.sd_setImage(with: URL(string: backgroundImage), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        recipeTitleLabel.text = title
        rankLabel.text = rank
        timeLabel.text = time
        
        var ingredients: String = ""
        for eachLine in ingredientsList {
            if eachLine == ingredientsList.last {
                ingredients.append(eachLine)
            } else {
                ingredients.append("\(eachLine), ")
            }
        }
        ingredientsListLabel.text = ingredients
    }
}
