// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorVolumeControl",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorVolumeControl",
            targets: ["VolumeControlPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "VolumeControlPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/VolumeControlPlugin"),
        .testTarget(
            name: "VolumeControlPluginTests",
            dependencies: ["VolumeControlPlugin"],
            path: "ios/Tests/VolumeControlPluginTests")
    ]
)