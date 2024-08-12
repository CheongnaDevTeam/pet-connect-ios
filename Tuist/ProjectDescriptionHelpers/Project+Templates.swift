//
//  Project+Templates.swift
//  Packages
//
//  Created by 이원빈 on 8/12/24.
//

import ProjectDescription

public extension Project {
    enum Layer: CaseIterable {
        case core
        
        public var layerName: String {
            switch self {
            case .core: return "Core"
            }
        }
    }
    
    static func makeProject(
        name: String,
        product: Product,
        settings: Settings,
        deploymentTarget: DeploymentTargets = .iOS("16.0"),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        let app: Target = .target(
            name: name,
            destinations: .iOS,
            product: product,
            bundleId: "com.cdt.\(name)",
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )

        let test: Target = .target(
            name: "\(name)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.cdt.\(name)Tests",
            deploymentTargets: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )

        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]

        let targets: [Target] = [app, test]

        return Project(
            name: name,
            organizationName: "PetConnect",
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
