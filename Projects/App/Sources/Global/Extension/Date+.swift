//
//  Date+.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

extension Date {
    /**
     # formatted
     - Note: 입력한 Format으로 변형한 String 반환
     - Parameters:
        - format: 변형하고자 하는 String타입의 Format (ex : "yyyy/MM/dd")
     - Returns: DateFormatter로 변형한 String
    */
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        return formatter.string(from: self)
    }
    
    public func getDateToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        return formatter.string(from: self)
    }
    
    /**
     # getStringToDate
     - Note: 서버에서 받은 String을 Date로 변환
     - Parameters:
        - string: 서버에서 받은 String Date (ex : "2022-05-26T18:06:55Z")
     - Returns: 변형한 Date
    */
    // TODO: 달이 18월 이런 식으로 잘못 나옴.. ㅠㅠ
    public static func getStringToDate(_ string: String) -> Self {
        let expectedFormat = Date.ISO8601FormatStyle()
        let date = try? Date(string, strategy: expectedFormat)
        return date ?? Date()
    }
    
}
