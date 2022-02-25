// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CBAppleMusicAPI",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15),
        .tvOS(.v11),
        .watchOS(.v5)
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
            dependencies: []),
        .testTarget(
            name: "CBAppleMusicAPITests",
            dependencies: [
                "CBAppleMusicAPI"
            ]
        ),
    ]
)
