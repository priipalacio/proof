#!/bin/sh
set -e  # parar si hay error

# Ruta raíz del proyecto generado
PROJECT_DIR="$(pwd)"

# Nombre del proyecto (cookiecutter lo reemplaza antes de ejecutar este hook)
APP_NAME="{{cookiecutter.project_name}}Demo"
DEMO_NAME="${APP_NAME}Demo"

mv "$PROJECT_DIR/$APPNAME" "$PROJECT_DIR/Demo"
