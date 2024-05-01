// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "NoLifeWzToNx",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "NoLifeWzToNx",
            targets: ["NoLifeWzToNxTool"]
        )
    ],
    targets: [
        .executableTarget(
            name: "NoLifeWzToNxTool",
            dependencies: [
                "CLZ4",
                "CSquish"
            ],
            publicHeadersPath: "include",
            cxxSettings: [
                .unsafeFlags([
                    "-I", "/opt/homebrew/Cellar/lz4/1.9.4/include",
                    "-I", "/opt/homebrew/Cellar/libsquish/1.15_1/include",
                ], .when(platforms: [.macOS]))
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("lz4"),
                .linkedLibrary("squish"),
                .unsafeFlags([
                    "-L/opt/homebrew/Cellar/lz4/1.9.4/lib",
                    "-L/opt/homebrew/Cellar/libsquish/1.15_1/lib"
                ], .when(platforms: [.macOS]))
            ]
        ),
        .systemLibrary(
            name: "CLZ4",
            pkgConfig: "lz4",
            providers: [
                .brew(["lz4"]), 
                .apt(["liblz4-dev"])
            ]
        ),
        .systemLibrary(
            name: "CSquish",
            pkgConfig: "squish",
            providers: [
                .brew(["libsquish"]),
                .apt(["libsquish-dev"])
            ]
        )
    ],
    cxxLanguageStandard: .cxx17
)
