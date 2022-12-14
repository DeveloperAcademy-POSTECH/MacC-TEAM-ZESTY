//
//  Project.swift
//  ZestyManifests
//
//  Created by Lee Myeonghwan on 2022/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeNetworkModule(
    name: "Network",
    product: .staticFramework,
    dependencies: [
        .external(name: "AWSS3")
    ]
)
