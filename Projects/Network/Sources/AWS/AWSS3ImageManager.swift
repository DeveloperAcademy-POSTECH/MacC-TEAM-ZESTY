//
//  ImageUploadManager.swift
//  Network
//
//  Created by Lee Myeonghwan on 2022/10/27.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Foundation
import AWSCore
import AWSS3
import Combine

final public class AWSS3ImageManager {
    
    // AWSS3keys
    private let accessKey = Bundle.main.infoDictionary?["AWSS3_ACCESS_KEY"] as? String ?? ""
    private let secretKey = Bundle.main.infoDictionary?["AWSS3_SECRET_KEY"] as? String ?? ""
    private let bucketName = Bundle.main.infoDictionary?["AWSS3_BUCKET_NAME"] as? String ?? ""
    
    // output
    public let uploadResultSubject = PassthroughSubject<String, ImageUploadError>()
    
    // configure provider
    private var filePath = ""
    private let utilityKey = "utility-key"
    private lazy var credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
    private lazy var serviceConfiguration = AWSServiceConfiguration(region: .APNortheast2, credentialsProvider: credentialsProvider)
    private let transferUtilityConfiguration: AWSS3TransferUtilityConfiguration = {
        $0.isAccelerateModeEnabled = false
        return $0
    }(AWSS3TransferUtilityConfiguration())
    
    // setting header
    private let expression: AWSS3TransferUtilityUploadExpression = {
        // URL로 이미지 읽을 수 있도록 권한 설정 (이 헤더 없으면 못읽음)
        $0.setValue("public-read", forRequestHeader: "x-amz-acl")
        return $0
    }(AWSS3TransferUtilityUploadExpression())
    
    public init() {
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        if let serviceConfiguration = serviceConfiguration {
            AWSS3TransferUtility.register(with: serviceConfiguration, forKey: utilityKey)
        }
        
    }
    
    // data만 바로 넘겨주면 됩니다.
    public func requestUpload(data: Data?) {
        guard let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: utilityKey) else {
            uploadResultSubject.send(completion: .failure(ImageUploadError.transferUtilityError))
            return
        }
        
        let completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock? = { [weak self] (task, _) -> Void in
            if let query = task.request?.url?.query,
               var removeQueryUrlString = task.request?.url?.absoluteString.replacingOccurrences(of: query, with: "") {
                removeQueryUrlString.removeLast()
                self?.uploadResultSubject.send(removeQueryUrlString)
            }
        }
        
        guard let pngData = data else {
            uploadResultSubject.send(completion: .failure(ImageUploadError.dataError))
            return
        }
        
        let fileName = UUID().uuidString
        
        transferUtility.uploadData(pngData, bucket: bucketName, key: filePath + fileName, contentType: "image/png", expression: expression,
                                   completionHandler: completionHandler).continueWith { [weak self] task in
            if let error = task.error {
                self?.uploadResultSubject.send(completion: .failure(ImageUploadError.uploadError(error)))
            }
            #if DEBUG
            if task.result != nil {
                print("upload successful.")
            }
            #endif
            return nil
        }
    }
    
}
