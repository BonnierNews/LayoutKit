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
        // ObjC-del
        .target(
            name: "LayoutKitObjC",
            path: "Sources",
            sources: [
                "ObjCSupport" // här ligger .m-filerna
            ],
            publicHeadersPath: ".", // eftersom LayoutKit.h / LayoutKitObjC.h ligger i Sources/
            exclude: [
                "Internal",
                "Layouts",
                "Math",
                "Views",
                "Alignment.swift",
                "Animation.swift",
                "AppKitSupport.swift",
                "Axis.swift",
                "ConfigurableLayout.swift",
                "Flexibility.swift",
                "Layout.swift",
                "LayoutArrangement.swift",
                "LayoutMeasurement.swift",
                "Text.swift",
                "UIKitSupport.swift",
                "ViewRecycler.swift",
                "ViewRecyclerViewStorage.swift",
                "Info.plist"
            ]
        ),
        // Swift-del
        .target(
            name: "LayoutKit",
            dependencies: ["LayoutKitObjC"],
            path: "Sources",
            exclude: [
                "ObjCSupport",
                "LayoutKit.h",
                "LayoutKitObjC.h",
                "Info.plist"
            ],
            sources: [
                "Internal",
                "Layouts",
                "Math",
                "Views",
                "Alignment.swift",
                "Animation.swift",
                "AppKitSupport.swift",
                "Axis.swift",
                "ConfigurableLayout.swift",
                "Flexibility.swift",
                "Layout.swift",
                "LayoutArrangement.swift",
                "LayoutMeasurement.swift",
                "Text.swift",
                "UIKitSupport.swift",
                "ViewRecycler.swift",
                "ViewRecyclerViewStorage.swift"
            ]
        ),
        // Tester
        .testTarget(
            name: "LayoutKitTests",
            dependencies: ["LayoutKit"],
            path: "Tests"
        )
    ]
)
