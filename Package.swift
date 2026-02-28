// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Nosh",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .executable(name: "Nosh", targets: ["Nosh"])
    ],
    targets: [
        .executableTarget(
            name: "Nosh",
            resources: [.process("Resources")]
        )
    ]
)
