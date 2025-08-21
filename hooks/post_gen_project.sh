#!/bin/bash
set -e

# Ruta raíz del proyecto generado
PROJECT_DIR="../"

# Creacion de directorios de Demo
DEMO_NAME="{{cookiecutter.project_name}}Demo"
mkdir "../Demo"
mkdir "../Demo/$DEMO_NAME"
mkdir "../Demo/${DEMO_NAME}Tests"
mkdir "../Demo/${DEMO_NAME}UITests"

#Creacion de archivos Demo
## DemoApp
cat > "../Demo/$DEMO_NAME/${DEMO_NAME}App.swift" <<EOF
import SwiftUI

@main
struct ${DEMO_NAME}App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
EOF
## Content View
cat > "../Demo/$DEMO_NAME/ContentView.swift" <<EOF
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello from ${DEMO_NAME}!")
    }
}

#Preview {
    ContentView()
}
EOF

## Crear Info.plist
cat > "../Demo/$DEMO_NAME/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>{{ cookiecutter.bundle_identifier }}</string>
    <key>CFBundleName</key>
    <string>${DEMO_NAME}</string>
</dict>
</plist>
EOF

## Crear archivos de demo tests
cat > "../Demo/${DEMO_NAME}UITests/${DEMO_NAME}UITestsLaunchTests.swift" <<EOF
import XCTest

final class ${DEMO_NAME}UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
EOF

cat > "../Demo/${DEMO_NAME}UITests/${DEMO_NAME}UITests.swift" <<EOF
import XCTest

final class {{cookiecutter.project_name}}DemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}

EOF

cat > "../Demo/${DEMO_NAME}Tests/${DEMO_NAME}Tests.swift" <<EOF
import Testing

struct {{cookiecutter.project_name}}DemoTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
EOF

cat > "../Package.swift" <<EOF
import PackageDescription

let package = Package(
    name: "{{cookiecutter.project_name}}",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "{{cookiecutter.project_name}}",
            targets: ["{{cookiecutter.project_name}}"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "{{cookiecutter.project_name}}"),
        .testTarget(
            name: "{{cookiecutter.project_name}}Tests",
            dependencies: ["{{cookiecutter.project_name}}"]
        ),
    ]
)
EOF
