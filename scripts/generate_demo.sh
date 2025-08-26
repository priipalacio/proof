#!/bin/bash
DEMO_NAME="{{cookiecutter.project_name}}"

mkdir -p ../Demo
mkdir -p ../Demo/${DEMO_NAME}Demo
mkdir -p ../Demo/${DEMO_NAMEDemoTests
mkdir -p ../Demo/${DEMO_NAMEDemoUITests

cd ../Demo

# App principal
cat > "../Demo/${DEMO_NAME}Demo/${DEMO_NAME}App.swift" <<EOF
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

# ContentView
cat > "../Demo/${DEMO_NAME}Demo/ContentView.swift" <<EOF
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

cat > "../Demo/${DEMO_NAME}DemoTests/${DEMO_NAME}DemoTests.swift" <<EOF
import XCTest
@testable import ${DEMO_NAME}

final class ${APP_NAME}DemoTests: XCTestCase {
    func testExample() throws {
        XCTAssertTrue(true)
    }
}
EOF

cat > "../Demo/${DEMO_NAME}DemoUITests/${DEMO_NAME}DemoUITests.swift" <<EOF
import XCTest

final class ${DEMO_NAME}DemoUITests: XCTestCase {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons.count >= 0)
    }
}
EOF
