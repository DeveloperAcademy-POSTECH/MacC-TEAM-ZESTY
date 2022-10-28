//
//  EvaluationSummary.swift
//  Network
//
//  Created by Chanhee Jeong on 2022/10/26.
//  Copyright © 2022 zesty. All rights reserved.
//

import Foundation

public struct EvaluationSummary: Decodable {
    public let goodCount, sosoCount, badCount: Int
}
