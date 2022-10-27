//
//  ImageUploadManager.swift
//  Network
//
//  Created by Lee Myeonghwan on 2022/10/27.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import AWSCore
import AWSS3

final class AWSS3ImageManager {
    
    private enum ImageUploadError {
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
    
    let accessKey = ""
    let secretKey = ""
    let utilityKey = ""
    let bucketName = ""
    var filePath = ""
    lazy var credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
    lazy var serviceConfiguration = AWSServiceConfiguration(region: .AFSouth1, credentialsProvider: credentialsProvider)
    let transferUtilityConfiguration: AWSS3TransferUtilityConfiguration = {
        $0.isAccelerateModeEnabled = false
        return $0
    }(AWSS3TransferUtilityConfiguration())
    
    let expression: AWSS3TransferUtilityUploadExpression = {
        // URL로 이미지 읽을 수 있도록 권한 설정 (이 헤더 없으면 못읽음)
        $0.setValue("public-read", forRequestHeader: "x-amz-acl")
        $0.progressBlock = {(_, progress) in
            print("progress \(progress.fractionCompleted)")
        }
        return $0
    }(AWSS3TransferUtilityUploadExpression())
    
    init() {
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        if let serviceConfiguration = serviceConfiguration {
            AWSS3TransferUtility.register(with: serviceConfiguration, forKey: utilityKey)
        }
        
    }
    
    // .pngData 메소드로 data 넘겨줘야합니다
    func requestUpload(data: Data?) {
        guard let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: utilityKey) else {
            print(ImageUploadError.transferUtilityError.localizedString)
            return
        }
        
        let completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock? = { [weak self] (task, _) -> Void in
            guard let self = self else { return }
            print("task finished")
            
            let url = AWSS3.default().configuration.endpoint.url
            let publicURL = url?.appendingPathComponent(self.bucketName).appendingPathComponent(self.filePath)
            if let absoluteString = publicURL?.absoluteString {
                print("image url ↓↓")
                print(absoluteString)
            }
            if let query = task.request?.url?.query,
               var removeQueryUrlString = task.request?.url?.absoluteString.replacingOccurrences(of: query, with: "") {
                removeQueryUrlString.removeLast() // 맨 뒤 물음표 삭제
                print("업로드 리퀘스트에서 쿼리만 제거한 url ↓↓") // 이 주소도 파일 열림
                print(removeQueryUrlString)
            }
        }
        // .pngData 메소드로 data 넘겨줘야합니다
        guard let pngData = data else {
            print(ImageUploadError.dataError.localizedString)
            return
        }
        
        let fileName = "testimage"
        
        transferUtility.uploadData(pngData, bucket: bucketName, key: filePath + fileName, contentType: "image/png", expression: expression,
                                   completionHandler: completionHandler).continueWith { task in
            if let error = task.error {
                print(ImageUploadError.uploadError(error).localizedString)
            }
            
            if task.result != nil {
                print("upload successful.")
            }
            
            return nil
        }
    }
}
