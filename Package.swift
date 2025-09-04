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
        // ObjC-only target
        .target(
            name: "LayoutKitObjC",
            path: "Sources/ObjCSupport",
            sources: ["Builders"],
            publicHeadersPath: "Builders"
        ),
        // Swift parts of ObjCSupport
        .target(
            name: "LayoutKitObjCSwift",
            dependencies: ["LayoutKitObjC"],
            path: "Sources/ObjCSupport",
            sources: [
                "Internal/ReverseWrappedLayout.swift",
                "Internal/WrappedLayout.swift",
                "LOKAlignment.swift",
                "LOKAnimation.swift",
                "LOKBaseLayout.swift",
                "LOKBatchUpdates.swift",
                "LOKButtonLayout.swift",
                "LOKButtonLayoutType.swift",
                "LOKFlexibility.swift",
                "LOKInsetLayout.swift",
                "LOKLabelLayout.swift",
                "LOKLayout.swift",
                "LOKLayoutArrangement.swift",
                "LOKLayoutArrangementSection.swift",
                "LOKLayoutMeasurement.swift",
                "LOKLayoutSection.swift",
                "LOKOverlayLayout.swift",
                "LOKReloadableViewLayoutAdapter.swift",
                "LOKSizeLayout.swift",
                "LOKStackLayout.swift",
                "LOKTextViewLayout.swift"
            ]
        ),
        // Main LayoutKit Swift code
        .target(
            name: "LayoutKit",
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
            path: "LayoutKitTests"
        )
    ]
)
