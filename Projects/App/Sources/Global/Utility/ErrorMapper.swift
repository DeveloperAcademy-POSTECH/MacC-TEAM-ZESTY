//
//  ErrorMapper.swift
//  App
//
//  Created by 리아 on 2022/10/27.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation
import Network

protocol ErrorMapper { }

extension ErrorMapper {
    
    func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .unauthorized, .forbidden:
            return "권한이 없습니다."
        case .serverError:
            return "서버에 문제가 발생했습니다. 다시 시도해주세요."
        case .unknown:
            return "알 수 없는 에러..🥲"
        default:
            return "문제가 발생했습니다. 제보해주시면 수정하도록 하겠습니다. 😂"
        }
    }
    
    func uploadErrorMessage(for error: ImageUploadError) -> String {
        switch error {
        case .urlError, .transferUtilityError:
            return "문제가 발생했습니다. 제보해주시면 수정하도록 하겠습니다. 😂"
        case .dataError, .uploadError(_):
            return "이미지 업로드 과정에서 문제가 발생했습니다. 다시 시도해주세요."
        }
    }
    
}
