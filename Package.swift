// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "istories",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "istories", targets: ["istories"]),
    ],
    targets: [
        .target(
            name: "istories",
            path: "src"
        ),
    ]
)
