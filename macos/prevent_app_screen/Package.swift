// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "prevent_app_screen",
    platforms: [
        .macOS(.v10_11)
    ],
    products: [
        .library(name: "prevent_app_screen", targets: ["prevent_app_screen"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "prevent_app_screen",
            dependencies: [],
            path: "Sources/prevent_app_screen",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
