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
        Category(id: 0, name: "한식", imageURL: "https://user-images.githubusercontent.com/63157395/197410857-e13c1bbb-b19a-4c59-a493-77501a4a529b.png"),
        Category(id: 1, name: "중식", imageURL: "https://user-images.githubusercontent.com/63157395/197410852-94dfcfb0-ebf5-48a4-af1a-5b4af65e8691.png"),
        Category(id: 2, name: "일식", imageURL: "https://user-images.githubusercontent.com/63157395/197410856-08e53c4c-29d3-4726-8600-f990f51be411.png"),
        Category(id: 3, name: "양식", imageURL: "https://user-images.githubusercontent.com/63157395/197410863-c948f14f-240b-4bb2-9733-06a244f52064.png"),
        Category(id: 4, name: "아시안", imageURL: "https://user-images.githubusercontent.com/63157395/197410896-9e18c0be-c298-4ddb-86b3-f2c636a0f180.png"),
        Category(id: 5, name: "분식", imageURL: "https://user-images.githubusercontent.com/63157395/197410849-98a47f44-674b-434a-9af8-54983f75a556.png"),
        Category(id: 6, name: "치킨", imageURL: "https://user-images.githubusercontent.com/63157395/197410851-8b192127-e86f-440d-8477-4a360261e89e.png"),
        Category(id: 7, name: "패스트푸드", imageURL: "https://user-images.githubusercontent.com/63157395/197410854-05805190-8281-44e5-8de8-5e212a32c76f.png"),
        Category(id: 8, name: "주점", imageURL: "https://user-images.githubusercontent.com/63157395/197410859-45b0047c-8660-46f3-b60f-f2ed1e2ac893.png"),
        Category(id: 9, name: "카페/디저트", imageURL: "https://user-images.githubusercontent.com/63157395/197410850-df9c7ad0-3469-4b4e-abdd-298cfcc82402.png"),
        Category(id: 10, name: "고기", imageURL: "https://user-images.githubusercontent.com/63157395/197410858-26fbbcc8-5179-4bfc-be63-5af1220ae3ea.png"),
        Category(id: 11, name: "회/해물", imageURL: "https://user-images.githubusercontent.com/63157395/197411793-25363f72-3e3c-4c92-85bb-b949320c34f4.png")
        
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
        User(id: 3, email: "lia@pos.idserve.net", social: .kakao, nickname: "리아", authToken: "dkd02j2", organizationId: 2),
        User(id: 4, email: "goban@pos.idserve.net", social: .kakao, nickname: "고바라바라만", authToken: "l3l9dxm", organizationId: 2),
        User(id: 5, email: "min@pos.idserve.net", social: .kakao, nickname: "오이는밍밍", authToken: "3o3kkd9", organizationId: 2)
    ]
}

extension Place {
    static let mockData: [Place] = [
        Place(id: 0,
              kakaoPlaceId: 0,
              creator: User.mockData[0],
              organizationId: 1,
              name: "순이",
              address: "경상북도 포항시 남구 지곡동 1-1 경상북도 포항시 남구 지곡동 1시 남구 지곡동 1-1경상북도 포항시 남구 지곡동 1-1",
              lat: "36.00922443856994",
              lan: "129.33335502427113",
              category: [Category.mockData[1], Category.mockData[2]],
              evaluationSum: EvaluationSum.mockData[0], reviews: []),
        Place(id: 1,
              kakaoPlaceId: 0,
              creator: User.mockData[0],
              organizationId: 0,
              name: "이태리파스타",
              address: "경상북도 포항시 남구 효자동 1-1",
              lat: "36.00922443856994",
              lan: "132.33335502427113",
              category: [Category.mockData[2], Category.mockData[4]],
              evaluationSum: EvaluationSum.mockData[0], reviews: [Review.mockData[0], Review.mockData[1], Review.mockData[2]]),
        Place(id: 2,
              kakaoPlaceId: 0,
              creator: User.mockData[0],
              organizationId: 0,
              name: "담박집",
              address: "경상북도 포항시 남구 지곡동 63",
              lat: "36.00922443856994",
              lan: "129.3876",
              category: [Category.mockData[5], Category.mockData[5]],
              evaluationSum: EvaluationSum.mockData[0], reviews: [Review.mockData[1], Review.mockData[2]]),
        Place(id: 3,
              kakaoPlaceId: 0,
              creator: User.mockData[0],
              organizationId: 0,
              name: "롯데리아",
              address: "경상북도 포항시 남구 지곡동 21",
              lat: "36.009224",
              lan: "128.2938",
              category: [Category.mockData[0], Category.mockData[3]],
              evaluationSum: EvaluationSum.mockData[0], reviews: [])
    ]
    
    static let empty: Place =
    Place(id: 0,
          kakaoPlaceId: 0,
          creator: User.mockData[0],
              organizationId: -1,
              name: "(가게정보없음)",
              address: "",
              lat: "",
              lan: "",
              category: [Category.init(id: -1, name: "카테고리", imageURL: nil)],
              evaluationSum: EvaluationSum(good: 0, soso: 0, bad: 0),
              reviews: [])
}

extension Review {
    static let mockData: [Review] = [
        Review(id: 0,
               placeId: 1,
               reviewer: User.mockData[1],
               evaluation: .soso,
               menuName: "스테이크",
               imageURL: "https://images.unsplash.com/photo-1546964124-0cce460f38ef?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
               createdAt: Date()),
        Review(id: 1,
               placeId: 2,
               reviewer: User.mockData[2],
               evaluation: .bad,
               menuName: "피자",
               imageURL: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
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
               evaluation: .soso,
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
