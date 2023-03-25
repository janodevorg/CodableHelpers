// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CodableHelpers",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v12),
        .tvOS(.v14)
    ],
    products: [
        .library(name: "CodableHelpers", type: .static, targets: ["CodableHelpers"]),
        .library(name: "CodableHelpersDynamic", type: .dynamic, targets: ["CodableHelpers"])
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
