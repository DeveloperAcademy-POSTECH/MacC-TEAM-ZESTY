//
//  Dependencies.swift
//  Config
//
//  Created by Lee Myeonghwan on 2022/10/27.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.11.3")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "9.0.0")),
        .remote(url: "https://github.com/aws-amplify/aws-sdk-ios-spm", requirement: .upToNextMajor(from: "2.28.0"))
    ],
    platforms: [.iOS]
)
