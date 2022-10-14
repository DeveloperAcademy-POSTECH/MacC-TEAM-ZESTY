//
//  Review.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

struct Review {
    let id: Int
    let place: Int
    let reviewer: User
    let evaluation: Evaluation
    let menuName: String
    let imageURL: String?
    let createdAt: Date
//    let updatedAt: Date
}

enum Evaluation {
    case good
    case soso
    case bad
}
