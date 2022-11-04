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
    
    func load(url: URL?) {
        guard let url = url else {
            self.image = UIImage(.img_errorfriends)
            return
        }
        self.kf.setImage(with: url) { result in
            switch result {
            case .success( _):
                break
            case .failure(let error):
                print("string -> image fail: \(error)")
                self.image = UIImage(.img_errorfriends)
            }
        }
    }
    
    static func load(url: URL?) -> UIImage? {
        let imageView = UIImageView()
        imageView.load(url: url)
        
        return imageView.image
    }
    
}
