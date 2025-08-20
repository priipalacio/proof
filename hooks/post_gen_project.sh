#!/bin/bash
set -e

# Ruta raíz del proyecto generado
PROJECT_DIR="$(pwd)"

# Entrar a la carpeta del proyecto donde está el project.yml
cd "$PROJECT_DIR/Demo"

# Ejecutar xcodegen
echo "⚡ Generando proyecto Xcode con XcodeGen..."
xcodegen generate
