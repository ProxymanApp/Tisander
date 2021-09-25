// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Tisander",
    platforms: [
        .macOS(.v10_13), .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Tisander",
            targets: ["Tisander"])
    ],
    targets: [
        .target(
            name: "Tisander",
            path: "Source"),
        .testTarget(
            name: "TisanderTests",
            dependencies: ["Tisander"],
            path: "Tests"),
    ]
)
