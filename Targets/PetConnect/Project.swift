//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 이원빈 on 8/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "PetConnect",
    product: .app,
    settings: .settings(
        base: .init().swiftCompilationMode(.wholemodule).automaticCodeSigning(devTeam: "SWPBG3YXG5")
    ),
    infoPlist: .default
)
