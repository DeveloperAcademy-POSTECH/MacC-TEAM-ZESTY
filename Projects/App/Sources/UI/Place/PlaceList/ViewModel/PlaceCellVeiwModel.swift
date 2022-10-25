//
//  PlaceCellVeiwModel.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit

final class PlaceCellVeiwModel {
    var placeName: String
    var category: Category
    var goodCount: Int
    var sosoCount: Int
    var badCount: Int
    var menuName: String?
    var reviewImage: UIImage?
    var isReviewExists: Bool = false
    
    init(placeName: String, category: Category, goodCount: Int, sosoCount: Int, badCount: Int, menuName: String?, reviewImage: UIImage?) {
        self.placeName = placeName
        self.category = category
        self.goodCount = goodCount
        self.sosoCount = sosoCount
        self.badCount = badCount
        
        // TODO: 버리 코드 머지 후 변경하기
        if reviewImage == nil {
            self.reviewImage = UIImage(.img_reviewfriends_bad)
            self.menuName = ""
        } else {
            self.menuName = menuName
            self.reviewImage = reviewImage
            self.isReviewExists = true
        }
    }
    
}
