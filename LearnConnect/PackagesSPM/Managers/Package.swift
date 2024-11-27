// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Managers",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Managers",
            targets: ["Managers"]
        ),
    ],
    dependencies: [
        .package(path: "../DataProvider"),
        .package(path: "../Utilities"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "11.5.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Managers",
            dependencies: [
                "DataProvider",
                "Utilities",
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "ManagersTests",
            dependencies: ["Managers"]),
    ]
)
