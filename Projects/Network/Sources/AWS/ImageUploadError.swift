//
//  ImageUploadError.swift
//  Network
//
//  Created by Lee Myeonghwan on 2022/10/27.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation

public enum ImageUploadError: Error {
    
    case urlError
    case transferUtilityError
    case dataError
    case uploadError(Error)
    
    public var localizedString: String {
        switch self {
        case .urlError:
            return "🚨url nil error🚨: 빈 url 입니다"
        case .transferUtilityError:
            return "🚨transferUtility nil error🚨 빈 transferUtility 입니다"
        case .dataError:
            return "🚨dataError nil error🚨 빈 data 입니다"
        case .uploadError(let error):
            return "🚨upload error🚨: \(error.localizedDescription)"
        }
    }
}
