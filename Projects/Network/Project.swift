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
        .remote(url: "https://github.com/awslabs/aws-sdk-swift", requirement: .upToNextMajor(from: "0.3.1"))
    ],
    dependencies: [
        .package(product: "AWSS3")
    ]
)
