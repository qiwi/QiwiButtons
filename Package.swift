// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "QiwiButtons",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        // The external product of our package is an importable
        // library that has the same name as the package itself:
        .library(
            name: "QiwiButtons",
            type: .static,
            targets: ["QiwiButtons"]
        )
    ],
    targets: [
        // Our package contains two targets, one for our library
        // code, and one for our tests:
        .target(name: "QiwiButtons", path: "QiwiButtons", exclude: ["Info.plist"])
    ],
    
    swiftLanguageVersions: [
        .v5
    ]
)
