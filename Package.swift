// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "CBAppleMusicAPI",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "CBAppleMusicAPI",
            targets: ["CBAppleMusicAPI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CBAppleMusicAPI",
            dependencies: [],
            swiftSettings: [
              .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "CBAppleMusicAPITests",
            dependencies: [
                "CBAppleMusicAPI"
            ]
        ),
    ]
)
