// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CBAppleMusicAPI",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_15),
        .tvOS(.v10),
        .watchOS(.v3)
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
