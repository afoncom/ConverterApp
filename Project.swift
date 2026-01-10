import ProjectDescription

let project = Project(
    name: "CurrencyConverter",
    organizationName: "afon-com",
    packages: [
        .remote(
            url: "https://github.com/SimplyDanny/SwiftLintPlugins",
            requirement: .exact("0.62.1")
        )
    ],
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": "9282D5CGQH",
            "IPHONEOS_DEPLOYMENT_TARGET": "17.0",
            "SWIFT_VERSION": "5.0",
            "ENABLE_USER_SCRIPT_SANDBOXING": "YES"
        ],
        configurations: [
            .debug(name: "Debug", xcconfig: nil),
            .release(name: "Release", xcconfig: nil)
        ]
    ),
    targets: [
        .target(
            name: "CurrencyConverter",
            destinations: [.iPhone],
            product: .app,
            bundleId: "afon-com.CurrencyConverter",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .file(path: "CurrencyConverter/Resources/Info.plist"),
            sources: [
                "CurrencyConverter/Sources/**"
            ],
            resources: [
                .glob(pattern: "CurrencyConverter/Resources/**", excluding: ["CurrencyConverter/Resources/Info.plist"])
            ],
            dependencies: [
                .package(product: "SwiftLintBuildToolPlugin", type: .plugin)
            ],
            settings: .settings(
                base: [
                    "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
                    "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
                    "CODE_SIGN_STYLE": "Automatic",
                    "CURRENT_PROJECT_VERSION": "1",
                    "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
                    "GENERATE_INFOPLIST_FILE": "NO",
                    "INFOPLIST_FILE": "CurrencyConverter/Resources/Info.plist",
                    "INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents": "YES",
                    "INFOPLIST_KEY_UILaunchStoryboardName": "LaunchScreen",
                    "INFOPLIST_KEY_UIMainStoryboardFile": "Main",
                    "INFOPLIST_KEY_UISupportedInterfaceOrientations": "UIInterfaceOrientationPortrait",
                    "MARKETING_VERSION": "1.0",
                    "PRODUCT_BUNDLE_IDENTIFIER": "afon-com.CurrencyConverter",
                    "PRODUCT_NAME": "$(TARGET_NAME)",
                    "SUPPORTED_PLATFORMS": "iphoneos iphonesimulator",
                    "SUPPORTS_MACCATALYST": "NO",
                    "SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD": "NO",
                    "SUPPORTS_XR_DESIGNED_FOR_IPHONE_IPAD": "NO",
                    "SWIFT_EMIT_LOC_STRINGS": "YES",
                    "TARGETED_DEVICE_FAMILY": "1"
                ],
                configurations: [],
                defaultSettings: .recommended
            )
        ),
        .target(
            name: "CurrencyConverterTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "afon-com.CurrencyConverterTests",
            deploymentTargets: .iOS("17.0"),
            sources: [
                "Tests/CurrencyConverterTests/**"
            ],
            dependencies: [
                .target(name: "CurrencyConverter")
            ]
        )
    ],
    schemes: [
        .scheme(
            name: "CurrencyConverter",
            shared: true,
            buildAction: .buildAction(targets: ["CurrencyConverter"]),
            testAction: .targets(["CurrencyConverterTests"]),
            runAction: .runAction(configuration: "Debug"),
            archiveAction: .archiveAction(configuration: "Release"),
            profileAction: .profileAction(configuration: "Release"),
            analyzeAction: .analyzeAction(configuration: "Debug")
        )
    ]
)
