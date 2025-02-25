// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "UserDefaultsObservation",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13), .visionOS(.v1)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserDefaultsObservation",
            targets: ["UserDefaultsObservation"]
        ),
        .executable(
            name: "UserDefaultsObservationClient",
            targets: ["UserDefaultsObservationClient"]
        ),
    ],
    dependencies: [
        // Depend on the latest Swift 5.9 prerelease of SwiftSyntax
        .package(url: "https://github.com/swiftlang/swift-syntax", from: "509.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "UserDefaultsObservationMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(name: "UserDefaultsObservation", dependencies: ["UserDefaultsObservationMacros"]),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "UserDefaultsObservationClient", dependencies: ["UserDefaultsObservation"]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "UserDefaultsObservationTests",
            dependencies: [
                "UserDefaultsObservationMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
