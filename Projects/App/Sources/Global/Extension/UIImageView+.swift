//
//  UIImageView+.swift
//  App
//
//  Created by 리아 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit.UIImageView
import UIKit.UIImage
import Kingfisher

extension UIImageView {
    
    func load(url: String?) {
        let url = URL(string: url!)
        self.kf.setImage(with: url) { result in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
                self.image = UIImage(named: "LoadFail.jpg")
            }
        }
    }
    
    static func load(url: String?) -> UIImage? {
        let imageView = UIImageView()
        imageView.load(url: url)
        
        return imageView.image
    }
    
}
