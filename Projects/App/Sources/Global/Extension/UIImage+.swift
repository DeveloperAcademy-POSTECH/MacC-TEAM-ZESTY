//
//  UIImage+.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit.UIImage
import Kingfisher

extension UIImage {
    
    func load(with urlString : String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}

extension String {
    
    func loadImage() -> UIImage {
        let image = UIImage()
        image.load(with: self)
        
        return image
    }
    
}
