// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IP2Location",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "IP2Location",
            targets: ["IP2Location"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
         .package(url: "https://github.com/swiftcsv/SwiftCSV.git", from: "0.5.5"),
         .package(path: "../Test-Resources"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "IP2Location",
            dependencies: ["SwiftCSV"]),
        .testTarget(
            name: "IP2LocationTests",
            dependencies: ["IP2Location"],
            path: "Tests"
        )
    ]
)
