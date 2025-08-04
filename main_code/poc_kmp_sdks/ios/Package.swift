// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "iOSSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "iOSSDK",
            targets: ["iOSSDK"]
        ),
    ],
    dependencies: [
        // Add any external Swift dependencies here
    ],
    targets: [
        .target(
            name: "iOSSDK",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "iOSSDKTests",
            dependencies: ["iOSSDK"],
            path: "Tests"
        ),
    ]
)