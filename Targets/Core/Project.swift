//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 이원빈 on 8/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Project.Layer.core.layerName,
    product: .staticFramework,
    settings: .settings(base: .init().swiftCompilationMode(.wholemodule)),
    dependencies: [
      .project(
        target: Project.Layer.networking.layerName,
        path: .relativeToRoot("Targets/\(Project.Layer.networking.layerName)")
      ),
      .project(
        target: Project.Layer.designSystem.layerName,
        path: .relativeToRoot("Targets/\(Project.Layer.designSystem.layerName)")
      )
    ]
)
