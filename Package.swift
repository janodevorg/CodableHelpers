// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "CodableHelpers",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "CodableHelpers", type: .dynamic, targets: ["CodableHelpers"]),
        .library(name: "CodableHelpersStatic", type: .static, targets: ["CodableHelpers"])
    ],
    dependencies: [
        .package(url: "git@github.com:apple/swift-docc-plugin.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "CodableHelpers",
            dependencies: [],
            path: "sources/main"
        ),
        .testTarget(
            name: "CodableHelpersTests",
            dependencies: ["CodableHelpers"],
            path: "sources/tests"
        )
    ]
)
