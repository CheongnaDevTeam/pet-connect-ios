// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:]
    )
#endif

let package = Package(
    name: "PetConnectIos",
    dependencies: [
      .package(url: "https://github.com/uber/RIBs.git", from: "0.14.1"),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.0"),
      .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0"),
      .package(url: "https://github.com/kakao/kakao-ios-sdk-rx.git", from: "2.22.0"),
      .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1")
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
    ]
)
