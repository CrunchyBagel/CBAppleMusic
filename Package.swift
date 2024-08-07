// swift-tools-version:6.0

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
            dependencies: []
        ),
        .testTarget(
            name: "CBAppleMusicAPITests",
            dependencies: [
                "CBAppleMusicAPI"
            ]
        ),
    ],
    swiftLanguageModes: [ .v6 ]
)
