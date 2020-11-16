// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "LogDogCocoaLumberjack",
    products: [
        .library(name: "LogDogCocoaLumberjack", targets: ["LogDogCocoaLumberjack"]),
    ],
    dependencies: [
        .package(url: "https://github.com/luoxiu/LogDog.git", .branch("master")),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.7.0"),
    ],
    targets: [
        .target(name: "LogDogCocoaLumberjack", dependencies: [
            "LogDog",
            .product(name: "CocoaLumberjackSwiftLogBackend", package: "CocoaLumberjack")
        ]),
        .testTarget(name: "LogDogCocoaLumberjackTests", dependencies: ["LogDogCocoaLumberjack"]),
    ]
)
