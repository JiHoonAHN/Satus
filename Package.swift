// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Satus",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "Satus", targets: ["Satus"]),
        .executable(name: "satus-cli", targets: ["SatusCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/files.git", from: "4.2.0")
    ],
    targets: [
        .target(
            name: "Satus",
            dependencies: [
                .product(name: "Files", package: "files")
            ]),
        .target(
            name: "SatusCLI",
            dependencies: ["SatusCLICore"]),
        .target(
            name: "SatusCLICore",
            dependencies: ["Satus"]
        ),
        .testTarget(
            name: "SatusTests",
            dependencies: ["Satus"]),
    ]
)
