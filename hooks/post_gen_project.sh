#!/bin/bash
set -e

# Ruta raíz del proyecto generado
PROJECT_DIR="../"
DEMO_NAME="{{cookiecutter.project_name}}"

mkdir -p ../Demo
mkdir -p ../Demo/{{cookiecutter.project_name}}Demo
mkdir -p ../Demo/{{cookiecutter.project_name}}DemoTests
mkdir -p ../Demo/{{cookiecutter.project_name}}DemoUITests

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

final class ${APP_NAME}DemoUITests: XCTestCase {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons.count >= 0)
    }
}
EOF


cd ../Demo
cat > "project.yml"<<EOF
name: {{cookiecutter.project_name}}Demo
options:
  minimumXcodeGenVersion: 2.0.0
  deploymentTarget:
    iOS: "15.0"

packages:
  {{cookiecutter.project_name}}:
    path: ../../{{cookiecutter.repository_name}}

targets:
  {{cookiecutter.project_name}}Demo:
    type: application
    platform: iOS
    bundleId: {{cookiecutter.bundle_identifier}}
    info:
      path: {{cookiecutter.project_name}}Demo/Info.plist
      properties:
        CFBundleIdentifier: {{cookiecutter.bundle_identifier}}
    sources:
      - path: ./{{cookiecutter.project_name}}Demo
    dependencies:
      - package: {{cookiecutter.project_name}}

  {{cookiecutter.project_name}}DemoTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - path: ./{{cookiecutter.project_name}}DemoTests
    dependencies:
      - target: {{cookiecutter.project_name}}Demo

  {{cookiecutter.project_name}}DemoUITests:
    type: bundle.ui-testing
    platform: iOS
    sources:
      - path: ./{{cookiecutter.project_name}}DemoUITests
    dependencies:
      - target: {{cookiecutter.project_name}}Demo
EOF

if command -v xcodegen >/dev/null 2>&1; then
  xcodegen generate
  rm project.yml
else
  echo "⚠️ XcodeGen no está instalado. Instalalo con: brew install xcodegen"
  exit 1
fi

cd ..
echo "# Changelog" > CHANGELOG.md
echo "" >> CHANGELOG.md
echo "All notable changes to this project will be documented in this file." >> CHANGELOG.md
echo "" >> CHANGELOG.md
echo "## [Unreleased]" >> CHANGELOG.md

# Generación del Package.swift
cat > "Package.swift" <<EOF
// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "{{cookiecutter.project_name}}",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "{{cookiecutter.project_name}}",
            targets: ["{{cookiecutter.project_name}}"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "{{cookiecutter.project_name}}",
            dependencies: [],
            path: "{{cookiecutter.project_name}}/Sources",
            resources: [
            .process("Resources/")
            ]
        ),
        .testTarget(
            name: "{{cookiecutter.project_name}}Tests",
            dependencies: ["{{cookiecutter.project_name}}"],
            path: "{{cookiecutter.project_name}}/Tests/Sources"
        ),
    ]
)
EOF
