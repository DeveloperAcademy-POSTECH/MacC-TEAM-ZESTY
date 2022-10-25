//
//  Project.swift
//  ZestyManifests
//
//  Created by Lee Myeonghwan on 2022/10/05.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "App",
    platform: .iOS,
    product: .app,
    packages: [
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.11.3")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "9.0.0"))
    ],
    dependencies: [
        .Projcet.Network,
        .Projcet.DesignSystem,
        .package(product: "KakaoSDK"),
        .package(product: "SnapKit"),
        .package(product: "Kingfisher"),
        .package(product: "FirebaseAnalytics"),
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Application/Info.plist")
)
