#!/bin/bash
set -e

# Ruta raíz del proyecto generado
PROJECT_DIR="../"

cat > "../project.yml"<<EOF
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
    bundleId: com.uala.{{cookiecutter.bundle_identifier}}
    sources:
      - path: {{cookiecutter.project_name}}Demo
        exclude:
         - project.yml
    dependencies:
      - package: {{cookiecutter.project_name}}

  {{cookiecutter.project_name}}DemoTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - path: {{cookiecutter.project_name}}DemoTests
    dependencies:
      - target: {{cookiecutter.project_name}}Demo

  {{cookiecutter.project_name}}DemoUITests:
    type: bundle.ui-testing
    platform: iOS
    sources:
      - path: {{cookiecutter.project_name}}DemoUITests
    dependencies:
      - target: {{cookiecutter.project_name}}Demo
EOF

echo "# Changelog" > CHANGELOG.md
echo "" >> CHANGELOG.md
echo "All notable changes to this project will be documented in this file." >> CHANGELOG.md
echo "" >> CHANGELOG.md
echo "## [Unreleased]" >> CHANGELOG.md

if command -v xcodegen >/dev/null 2>&1; then
  xcodegen generate
else
  echo "⚠️ XcodeGen no está instalado. Instalalo con: brew install xcodegen"
  exit 1
fi
