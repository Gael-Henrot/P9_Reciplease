//
//  RecipeTableViewCell.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 13/09/2021.
//

import UIKit
import Alamofire
import AlamofireImage

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String, backgroundImage: UIImage, ingredientsList: [String], rank: String, time: String) {
        recipeImage.image = backgroundImage
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
