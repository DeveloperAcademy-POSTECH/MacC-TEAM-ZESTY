//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Lee Myeonghwan on 2022/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "DesignSystem",
    product: .framework,
    packages: [],
    dependencies: [],
    resources: ["Resources/**"]
)
