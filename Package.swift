// swift-tools-version:5.2

import PackageDescription


#if os(macOS)
let mysqlclientPath = "Sources/mysqlclient-macos"
#else
let mysqlclientPath =  "Sources/mysqlclient"
#endif

let package = Package(
	name: "PerfectMySQL",
    platforms: [
        .macOS(.v10_15)
    ],
	products: [
		.library(name: "PerfectMySQL", targets: ["PerfectMySQL"])
	],
	dependencies: [
        .package(name: "PerfectCRUD", url: "https://github.com/123FLO321/Perfect-CRUD.git", .branch("swift5"))
    ],
	targets: [
        .systemLibrary(
            name: "mysqlclient",
            path: mysqlclientPath,
            pkgConfig: "mysqlclient",
            providers: [
                .brew(["mysql"]),
                .apt(["libmysqlclient-dev"]),
            ]
        ),
		.target(name: "PerfectMySQL", dependencies: ["PerfectCRUD", "mysqlclient"]),
		.testTarget(name: "PerfectMySQLTests", dependencies: ["PerfectMySQL"])
	]
)
