//
//  Project.swift
//  CoreManifests
//
//  Created by 이원빈 on 9/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: Project.Layer.designSystem.layerName,
    product: .staticFramework,
    settings: .settings(base: .init().swiftCompilationMode(.wholemodule)),
    dependencies: [
      .external(name: "RxSwift"),
      .external(name: "RxCocoa"),
      .external(name: "SnapKit")
    ],
    resources: ["Resources/**"]
)
