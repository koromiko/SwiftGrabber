// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGrabber",
    products: [
        .library(name: "libGrabber", targets: ["libGrabber"]),
        .executable(name: "SwiftGrabber", targets: ["SwiftGrabber"])
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftGrabber", dependencies: ["libGrabber"]),
        .target(name: "libGrabber", dependencies: []),
        .testTarget(name: "SwiftGrabberTests", dependencies: ["libGrabber", "SwiftGrabber"])
    ]
)
