//
//  MockData.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/14.
//  Copyright © 2022 zesty. All rights reserved.
//
import Foundation

extension Category {
    static let mockData: [Category] = [
        Category(id: 0, name: "한식"),
        Category(id: 1, name: "중식"),
        Category(id: 2, name: "일식"),
        Category(id: 3, name: "양식"),
        Category(id: 4, name: "분식"),
        Category(id: 5, name: "회"),
        Category(id: 6, name: "디저트")
    ]
}

extension Organization {
    static let mockData: [Organization] = [
        Organization(id: 0, name: "애플대", domain: "@pos.idserve.net", memberCount: 12, imageCount: 32, placeCount: 2),
        Organization(id: 1, name: "서울대", domain: "@snu.ac.kr", memberCount: 100, imageCount: 2, placeCount: 3),
        Organization(id: 2, name: "부산대", domain: "@pnu.ac.kr", memberCount: 32, imageCount: 9, placeCount: 34)
    ]
}

extension User {
    static let mockData: [User] = [
        User(id: 0, email: "avery@pos.idserve.net", social: .kakao, nickname: "버리", authToken: "dkjds8d2", organizationId: 0),
        User(id: 1, email: "avo@pos.idserve.net", social: .kakao, nickname: "카도아보", authToken: "fkdis09n", organizationId: 0),
        User(id: 2, email: "nick@pos.idserve.net", social: .kakao, nickname: "닉", authToken: "d8s82m", organizationId: 1),
        User(id: 3, email: "lia@pos.idserve.net", social: .kakao, nickname: "리아", authToken: "dkd02j2", organizationId: 1),
        User(id: 4, email: "goban@pos.idserve.net", social: .kakao, nickname: "고바라바라만", authToken: "l3l9dxm", organizationId: 2),
        User(id: 5, email: "min@pos.idserve.net", social: .kakao, nickname: "오이는밍밍", authToken: "3o3kkd9", organizationId: 2)
    ]
}

extension Place {
    static let mockData: [Place] = [
        Place(id: 0,
              creator: User.mockData[0],
              organizationId: Organization.mockData[0].id,
              name: "순이",
              address: "경상북도 포항시 남구 지곡동 1-1",
              lat: "36.00922443856994",
              lan: "129.33335502427113",
              category: [Category.mockData[1], Category.mockData[2]],
              evaluationSum: EvaluationSum.mockData[0],
              reviews: []),
        Place(id: 1,
              creator: User.mockData[0],
              organizationId: Organization.mockData[0].id,
              name: "이태리파스타",
              address: "경상북도 포항시 남구 효자동 1-1",
              lat: "36.00922443856994",
              lan: "132.33335502427113",
              category: [Category.mockData[2], Category.mockData[4]],
              evaluationSum: EvaluationSum.mockData[0], reviews: []),
        Place(id: 2,
              creator: User.mockData[0],
              organizationId: Organization.mockData[0].id,
              name: "담박집",
              address: "경상북도 포항시 남구 지곡동 63",
              lat: "36.00922443856994",
              lan: "129.3876",
              category: [Category.mockData[5], Category.mockData[7]],
              evaluationSum: EvaluationSum.mockData[0], reviews: []),
        Place(id: 3,
              creator: User.mockData[0],
              organizationId: Organization.mockData[0].id,
              name: "롯데리아",
              address: "경상북도 포항시 남구 지곡동 21",
              lat: "36.009224",
              lan: "128.2938",
              category: [Category.mockData[0], Category.mockData[3]],
              evaluationSum: EvaluationSum.mockData[0], reviews: [])
    ]
}

extension Review {
    static let mockData: [Review] = [
        Review(id: 0,
               placeId: 1,
               reviewer: User.mockData[1],
               evaluation: .good,
               menuName: nil,
               imageURL: nil,
               createdAt: Date()),
        Review(id: 1,
               placeId: 2,
               reviewer: User.mockData[2],
               evaluation: .bad,
               menuName: "피자",
               imageURL: "https://unsplash.com/photos/MqT0asuoIcU",
               createdAt: Date()),
        Review(id: 2,
               placeId: 2,
               reviewer: User.mockData[3],
               evaluation: .good,
               menuName: "샐러드",
               imageURL: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
               createdAt: Date()),
        Review(id: 3,
               placeId: 1,
               reviewer: User.mockData[4],
               evaluation: .good,
               menuName: "토스트",
               imageURL: "https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
               createdAt: Date())
    ]
}

extension EvaluationSum {
    static let mockData: [EvaluationSum] = [
        EvaluationSum(good: 10, soso: 2, bad: 3),
        EvaluationSum(good: 3, soso: 12, bad: 3),
        EvaluationSum(good: 2, soso: 23, bad: 2)
    ]
}
