#!/bin/bash
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
