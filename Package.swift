// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mediatag",
    platforms: [.iOS(.v12), .tvOS(.v12)],
    products: [
      .library(
        name: "Mediatag",
        targets: ["MediatagSDK"]
      )
    ],
    dependencies: [],
    targets: [
      .binaryTarget(
          name: "MediatagSDK",
          url: "https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin/releases/download/1.2.6/MediatagSDK.xcframework.zip",
          checksum: "e1be0c9220f9d87f7ac2213ff7a84ff17bb5308e07dddea2e376a01c09e912d8"
      )
    ]
)
