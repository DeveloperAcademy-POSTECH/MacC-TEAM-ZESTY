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
        .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.6.1")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0"))
    ],
    dependencies: [
        .Projcet.Network,
        .Projcet.DesignSystem,
        .package(product: "SnapKit"),
        .package(product: "Alamofire"),
        .package(product: "Kingfisher")
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Sources/Application/Info.plist")
)
