// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Accounting",
    platforms: [
        .macOS(.v10_15), // incorpoated Combine so that we can publish the ChartOfAccounts account list.
        .iOS("13.0"), // incorpoated Combine so that we can publish the ChartOfAccounts account list.
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Accounting",
            targets: ["Accounting"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/pcordone/DataStructures.git", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Accounting",
            dependencies: ["DataStructures"]),
        .testTarget(
            name: "AccountingTests",
            dependencies: ["Accounting"]),
    ]
)
