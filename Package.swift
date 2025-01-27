// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DeviceID",
    products: [
        .library(
            name: "DeviceID",
            targets: ["DeviceID"]
        ),
    ],
    targets: [
        .target(
            name: "DeviceID",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
            ]
        ),
    ]
)
