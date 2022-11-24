// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Satus",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "Satus", targets: ["Satus"]),
        .executable(name: "satus-cli", targets: ["SatusCLI"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Satus",
            dependencies: []),
        .target(
            name: "SatusCLI",
            dependencies: ["SatusCLICore"]),
        .target(
            name: "SatusCLICore",
            dependencies: []
        ),
        .testTarget(
            name: "SatusTests",
            dependencies: ["Satus"]),
    ]
)
