// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTMLParserBenchmarkSwift",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "HTMLParserBenchmarkSwift",
            targets: ["HTMLParserBenchmarkSwift"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
        .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "5.2.7"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "HTMLParserBenchmarkSwift",
            dependencies: ["SwiftSoup"],
            resources: [
            ]
        ),
        .testTarget(
            name: "HTMLParserBenchmarkSwiftTests",
            dependencies: ["HTMLParserBenchmarkSwift", "SwiftSoup", "Kanna"],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
