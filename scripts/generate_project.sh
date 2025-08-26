#!/bin/bash

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
