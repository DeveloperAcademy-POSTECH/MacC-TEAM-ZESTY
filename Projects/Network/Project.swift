//
//  Project.swift
//  ZestyManifests
//
//  Created by Lee Myeonghwan on 2022/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Network",
    product: .staticFramework,
    packages: [
        .remote(url: "https://github.com/aws-amplify/aws-sdk-ios-spm", requirement: .upToNextMajor(from: "2.28.0"))
    ],
    dependencies: [
        .package(product: "AWSS3")
    ]
)
