#!/bin/bash

set -e

DEMO_NAME="{{cookiecutter.project_name}}"

mkdir -p ../Demo
mkdir -p ../Demo/${DEMO_NAME}Demo
mkdir -p ../Demo/${DEMO_NAME}DemoTests
mkdir -p ../Demo/${DEMO_NAME}DemoUITests

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

cd ../Demo
cat > "project.yml"<<EOF
name: {{cookiecutter.project_name}}Demo
options:
  minimumXcodeGenVersion: 2.0.0
  deploymentTarget:
    iOS: "15.0"

packages:
  {{cookiecutter.project_name}}:
    path: ../{{cookiecutter.project_name}}

targets:
  {{cookiecutter.project_name}}Demo:
    type: application
    platform: iOS
    bundleId: {{cookiecutter.bundle_identifier}}
    info:
      path: {{cookiecutter.project_name}}Demo/Info.plist
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: {{cookiecutter.bundle_identifier}}
        INFOPLIST_FILE: {{cookiecutter.project_name}}Demo/Info.plist
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
# Generacion de Changelog
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

# Generacion de LICENSE

echo "MIT License" > LICENSE
echo "" >> LICENSE
echo "Copyright (c) {{cookiecutter.creation_year}} {{cookiecutter.dev_name}}" >> LICENSE
echo "" >> LICENSE
echo "Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
" >> LICENSE


# MARK: generate github workflows

mkdir -p .github/workflows

cd .github/workflows

cat > danger.yml << EOF
name: 🚧 Danger

on:
  pull_request:
    types: ["opened", "edited"]

jobs:
    Danger-swift:
      uses:
          Empres/nombre-repo/.dsadas
      secrets: inherit
EOF
