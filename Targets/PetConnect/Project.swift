//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 이원빈 on 8/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "CFBundleDisplayName": "$(PRODUCT_NAME)",
    "UILaunchStoryboardName": "LaunchScreen",
    "UIUserInterfaceStyle": "Light",
    "CFBundleURLTypes": [
        [
            "CFBundleTypeRole": "Editor",
            "CFBundleURLSchemes": ["kakao${KAKAO_NATIVE_APP_KEY}"]
        ]
    ],
    "KAKAO_NATIVE_APP_KEY": "${KAKAO_NATIVE_APP_KEY}",
    "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaolink"],
    "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
    "UIApplicationSupportsIndirectInputEvents": true,
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "LSSupportsOpeningDocumentsInPlace": true
]

let project = Project.makeProject(
    name: "PetConnect",
    product: .app,
    settings: .settings(
        base: .init().swiftCompilationMode(.wholemodule).automaticCodeSigning(devTeam: "SWPBG3YXG5"),
        configurations: [
          .debug(name: "Debug", xcconfig: .relativeToCurrentFile("Config/Debug.xcconfig")),
          .release(name: "Release", xcconfig: .relativeToCurrentFile("Config/Release.xcconfig"))
        ]
    ),
    dependencies: [
      .project(target: Project.Layer.core.layerName, path: .relativeToRoot("Targets/\(Project.Layer.core.layerName)")),
      .external(name: "ComposableArchitecture"),
      .external(name: "KakaoSDK")
    ],
    entitlements: .file(path: "PetConnect.entitlements"),
    infoPlist: .extendingDefault(with: infoPlist)
)

//extension Package {
//  static let ComposableArchitecture = Package.remote(
//      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
//      requirement: .exact("0.52.0")
//  )
//
//  static let TCACoordinators = Package.remote(
//      url: "https://github.com/johnpatrickmorgan/TCACoordinators.git",
//      requirement: .exact("0.4.0")
//  )
//}
//
//extension TargetDependency {
//  public struct SPM {
//    public static let ComposableArchitecture = TargetDependency.external(name: "ComposableArchitecture")
//    public static let TCACoordinators = TargetDependency.external(name: "TCACoordinators")
//  }
//}
