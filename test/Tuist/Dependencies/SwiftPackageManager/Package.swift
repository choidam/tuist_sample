// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
        .package(url: "https://github.com/devxoul/Then", from: "3.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMinor(from: "6.5.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxNimble.git", from: "5.0.0"),
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
    ]
)