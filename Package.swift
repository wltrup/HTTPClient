// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "HTTPClient",
    products: [
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HTTPClient",
            dependencies: []
        ),
        .testTarget(
            name: "HTTPClientTests",
            dependencies: ["HTTPClient"]
        ),
    ]
)
