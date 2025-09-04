// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "LayoutKit",
    platforms: [
        .iOS(.v11),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "LayoutKit",
            targets: ["LayoutKit"]
        )
    ],
    targets: [
        // ObjC-delen
        .target(
            name: "LayoutKitObjC",
            path: "Sources/ObjCSupport",
            publicHeadersPath: "."
        ),
        // Swift-delen
        .target(
            name: "LayoutKit",
            dependencies: ["LayoutKitObjC"],
            path: "Sources",
            exclude: [
                "ObjCSupport",
                "LayoutKit.h",
                "LayoutKitObjC.h",
                "Info.plist"
            ]
        ),
        .testTarget(
            name: "LayoutKitTests",
            dependencies: ["LayoutKit"],
            path: "Tests"
        )
    ]
)
