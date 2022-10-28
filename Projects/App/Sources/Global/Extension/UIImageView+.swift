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
        guard let url = URL(string: url ?? "") else {
            self.image = UIImage(.img_errorfriends)
            return
        }
        self.kf.setImage(with: url) { result in
            switch result {
            case .success( _):
                break
            case .failure(let error):
                print(error)
                self.image = UIImage(.img_errorfriends)
            }
        }
    }
    
    // TODO: String -> URL 로 파라미터 타입 변경하기
    static func load(url: String?) -> UIImage? {
        let imageView = UIImageView()
        imageView.load(url: url)
        
        return imageView.image
    }
    
}
