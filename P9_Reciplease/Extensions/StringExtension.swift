//
//  StringExtension.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 17/09/2021.
//

import Foundation

// This extension allows to retrieve the data from an url.
// It is used for get the picture of each recipe.

extension String {
    var downloadData: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
