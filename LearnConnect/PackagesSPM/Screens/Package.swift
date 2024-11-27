// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Screens",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Screens",
            targets: ["Screens"]),
    ],
    dependencies: [
        .package(path: "../UIComponents"),
        .package(path: "../Managers"),
        .package(url: "https://github.com/slackhq/PanModal.git", .upToNextMajor(from: "1.2.6"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Screens",
            dependencies: [
                "UIComponents",
                "Managers",
                "PanModal"
            ]
        ),
        .testTarget(
            name: "ScreensTests",
            dependencies: ["Screens"]),
    ]
)
