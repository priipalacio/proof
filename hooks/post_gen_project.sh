#!/bin/bash
set -e  # parar si hay error

# Ruta raíz del proyecto generado
PROJECT_DIR="$(pwd)"

# Nombre del proyecto (cookiecutter lo reemplaza antes de ejecutar este hook)
APP_NAME="{{ cookiecutter.project_name }}"
DEMO_NAME="${APP_NAME}Demo"

# Crear carpeta Demo si no existe
mkdir -p "$PROJECT_DIR/Demo"

# Crear estructura de un proyecto Xcode de ejemplo
mkdir -p "$PROJECT_DIR/Demo/${DEMO_NAME}"
mkdir -p "$PROJECT_DIR/Demo/${APP_NAME}DemoTests"
mkdir -p "$PROJECT_DIR/Demo/${APP_NAME}DemoUITests"

# Archivos básicos
cat > "$PROJECT_DIR/Demo/${DEMO_NAME}/${DEMO_NAME}App.swift" <<EOF
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

cat > "$PROJECT_DIR/Demo/${DEMO_NAME}/ContentView.swift" <<EOF
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

cat > "$PROJECT_DIR/Demo/${APP_NAME}DemoTests/${APP_NAME}DemoTests.swift" <<EOF
import XCTest
@testable import ${DEMO_NAME}

final class ${APP_NAME}DemoTests: XCTestCase {
    func testExample() throws {
        XCTAssertTrue(true)
    }
}
EOF

cat > "$PROJECT_DIR/Demo/${APP_NAME}DemoUITests/${APP_NAME}DemoUITests.swift" <<EOF
import XCTest

final class ${APP_NAME}DemoUITests: XCTestCase {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons.count >= 0)
    }
}
EOF
