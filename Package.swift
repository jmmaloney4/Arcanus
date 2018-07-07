// swift-tools-version:4.0
// Copyright © 2018 Jack Maloney. All Rights Reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import PackageDescription

let package = Package(name: "Arcanus",
                      products: [.library(name: "Arcanus", targets: ["Arcanus"]),
                                 .executable(name: "arcanus", targets: ["CLI"])],
                      dependencies: [.package(url: "https://github.com/jmmaloney4/CommandLine.git", .branch("master")),
                                     .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
                                     .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.5.2"),
                                     .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
                                     .package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git", from: "3.0.0"),
                                     
        /*
        .package(url: "https://github.com/jmmaloney4/Squall.git", from: "1.2.3"),
        .package(url: "https://github.com/davecom/SwiftPriorityQueue.git", from: "1.2.1"),
        .package(url: "https://github.com/jmmaloney4/Weak.git", from: "0.1.0"),
        .package(url: "https://github.com/PerfectlySoft/PerfectLib.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git", from: "3.0.0")
        .package(url: "https://github.com/mxcl/PromiseKit", from: "6.2.9"),
        .package(url: "https://github.com/jmmaloney4/ClibSwiftNCurses.git", .branch("master")),
        .package(url: "https://github.com/evgenyneu/SigmaSwiftStatistics.git", from: "7.0.2"),
        .package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", from: "17.0.0"),
        */ ],
                      targets: [.target(name: "Arcanus", dependencies: ["SwiftyBeaver",
                                                                        // "SigmaSwiftStatistics",
                                                                        // "SwiftyJSON",
                                                                        // "PromiseKit",
                                                                        // "PerfectLib",
                                                                        "PerfectHTTPServer",
                                                                        "PerfectLogger"]),
                      .target(name: "CLI", dependencies: ["Arcanus",
                                                          "SwiftyBeaver",
                                                          "CommandLine",
                                                          "Rainbow"])],
                      swiftLanguageVersions: [4])
