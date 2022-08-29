// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
        .package(url: "https://github.com/devxoul/Then", from: "3.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMinor(from: "6.5.0")),
    ]
)