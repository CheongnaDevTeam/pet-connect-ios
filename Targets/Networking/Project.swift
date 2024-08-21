//
//  Project.swift
//  CoreManifests
//
//  Created by 이원빈 on 8/21/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Project.Layer.networking.layerName,
    product: .staticFramework,
    settings: .settings(base: .init().swiftCompilationMode(.wholemodule)),
    dependencies: [
      .project(
        target: Project.Layer.networkingInterface.layerName,
        path: .relativeToRoot("Targets/\(Project.Layer.networkingInterface.layerName)")
      )
    ]
)
