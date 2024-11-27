// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UIComponents",
            targets: ["UIComponents"])
    ],
    dependencies: [
        .package(path: "../Utilities"),
        .package(path: "../Resources"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.3.4"),
        .package(url: "https://github.com/roberthein/TinyConstraints.git", branch: "master"),
        .package(url: "https://github.com/huri000/SwiftEntryKit", .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        .target(
            name: "UIComponents",
            dependencies: [
                "Utilities",
                "Resources",
                "TinyConstraints",
                "SwiftEntryKit"
            ],
            plugins: [
                .plugin(name: "Lottie", package: "lottie-spm")
            ]
        )
    ]
)
