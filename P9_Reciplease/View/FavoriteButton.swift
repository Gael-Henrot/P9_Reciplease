//
//  FavoriteButton.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 30/09/2021.
//

import UIKit

class FavoriteButton: UIBarButtonItem {
    override init() {
        tintColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var isTapped: Bool = false {
        didSet {
            if isTapped == true {
                self.image = UIImage(systemName: "star.fill")
            } else {
                self.image = UIImage(systemName: "star")
            }
        }
    }
}
