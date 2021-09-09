// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Tanker",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
//        .package(url: "https://github.com/doHernandezM/SwiftyPi.git", .upToNextMajor(from: "0.1.8")),
        .package(url: "https://github.com/doHernandezM/SwiftyPi.git", ._exactItem("0.1.13")),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "SwiftyPi", package: "SwiftyPi"),
            ],
            swiftSettings: [
                // Enable better optimizations when buildSwiftyPiing in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
