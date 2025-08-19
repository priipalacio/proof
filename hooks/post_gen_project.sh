#!/bin/bash
set -e

PROJECT_DIR="$(pwd)"
APP_NAME="{{ cookiecutter.project_name }}"
DEMO_NAME="${APP_NAME}Demo"

mkdir -p "$PROJECT_DIR/Demo/$DEMO_NAME"

# Crear un project.yml dinámico
cat > "$PROJECT_DIR/Demo/project.yml" <<EOF
name: $DEMO_NAME
options:
  bundleIdPrefix: com.example
targets:
  $DEMO_NAME:
    type: application
    platform: iOS
    sources:
      - $DEMO_NAME
    scheme:
      testTargets:
        - ${APP_NAME}DemoTests
  ${APP_NAME}DemoTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - ${APP_NAME}DemoTests
    dependencies:
      - target: $DEMO_NAME
  ${APP_NAME}DemoUITests:
    type: bundle.ui-testing
    platform: iOS
    sources:
      - ${APP_NAME}DemoUITests
    dependencies:
      - target: $DEMO_NAME
EOF

# Crear carpetas de código
mkdir -p "$PROJECT_DIR/Demo/$DEMO_NAME"
mkdir -p "$PROJECT_DIR/Demo/${APP_NAME}DemoTests"
mkdir -p "$PROJECT_DIR/Demo/${APP_NAME}DemoUITests"

# Generar el Xcode project
cd "$PROJECT_DIR/Demo"
/opt/homebrew/bin/xcodegen generate
