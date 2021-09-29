//
//  ImageProvider.swift
//  P9_Reciplease
//
//  Created by Gaël HENROT on 29/09/2021.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageProvider {
    
    static let imageCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024, preferredMemoryUsageAfterPurge: 60 * 1024 * 1024)
    
    func provideImage(from url: String, withIdentifier identifier: String) {
        AF.request(url)
            .responseImage { response in
                switch response.result {
                case .failure(_):
                    print("The recipe image download with identifier \(identifier) failed.")
                    return
                    
                case .success(let image):
                    ImageProvider.imageCache.add(image, withIdentifier: identifier)
                }
            }
    }
    
}
