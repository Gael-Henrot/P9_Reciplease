//
//  FavoriteButton.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 30/09/2021.
//

import UIKit

class FavoriteButton: UIBarButtonItem {
    var isFavorite: Bool = false {
        didSet {
            if isFavorite == true {
                self.image = UIImage(systemName: "star.fill")
            } else {
                self.image = UIImage(systemName: "star")
            }
        }
    }
}
