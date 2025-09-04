// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "LayoutKit",
    platforms: [
        .iOS(.v11),
        .tvOS(.v11)
    ],
    products: [
        .library(name: "LayoutKit", targets: ["LayoutKit"])
    ],
    targets: [
        .target(
            name: "LayoutKit",
            path: "Sources",
            exclude: [
                "ObjCSupport",
                "ObjCSupport/Builders/LOKButtonLayoutBuilder.h",
                "LayoutKit.h",
                "LayoutKitObjC.h",
                "Info.plist"
            ]
        )
    ]
)
