//
//  Place.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

struct User { // 바뀔 수 있을 듯
    let id: Int
    // let provider: Provider
    let nickname: String
    let token: String
}

enum Provider: String {
    case apple = "APPLE"
    case kakao = "KAKAO"
}

struct Org {
    let id: Int
    let name: String
    let address: String
    let memberCount: Int
    let imageCount: Int
    let placeCount: Int
}

struct Place {
    let id: Int
    let orgId: Int
    let creator: User
    let name: String
    let address: String
    let lat: String
    let lan: String
    let category: [Category]
    let evaluationSum: EvaluationSum
//    let reviews: [Review]
}

struct Category { // 카테고리 -> 서버에 두는가?
    let id: Int
    let name: String
}

struct Review {
    let id: Int
    let reviewer: User
    let evaluation: Evaluation
     let menuName: String
    let imageURL: String?
    let date: Date
}

struct EvaluationSum { // EvaluationSummary
    let good: Int
    let soso: Int
    let bad: Int
}

enum Evaluation {
    case good
    case soso
    case bad
}

extension Place {
    static let mockedData: [Place] = [
        Place(id: 1,
              orgId: 2,
              creator: User.mockedData[1],
              name: "담박집",
              address: "경상북도 포항시 남구 지곡동",
              lat: "36.00922443856994",
              lan: "129.33335502427113",
              category: [Category.mockedData[1], Category.mockedData[2]],
              evaluationSum: EvaluationSum.mockedData[0])
    
    ]
}

extension User {
    static let mockedData: [User] = [
        User(id: 1, nickname: "버리", token: "12345678"),
        User(id: 2, nickname: "아보", token: "dasfdsa8fd8"),
        User(id: 1, nickname: "고반", token: "diadmd92"),
        User(id: 1, nickname: "민", token: "3k3kd9d0"),
        User(id: 1, nickname: "리아", token: "ssl2l2o"),
        User(id: 1, nickname: "닉", token: "3k3k3k")
    ]
}

extension Category {
    static let mockedData: [Category] = [
        Category(id: 0, name: "한식"),
        Category(id: 1, name: "중식"),
        Category(id: 2, name: "일식"),
        Category(id: 3, name: "양식"),
        Category(id: 4, name: "분식"),
        Category(id: 5, name: "회"),
        Category(id: 6, name: "디저트")
    ]
}

extension EvaluationSum {
    static let mockedData: [EvaluationSum] = [
        EvaluationSum(good: 10, soso: 2, bad: 3),
        EvaluationSum(good: 0, soso: 12, bad: 3)
    ]
}
