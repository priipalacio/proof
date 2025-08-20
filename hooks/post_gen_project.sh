#!/bin/sh
set -e  # parar si hay error

# Ruta raíz del proyecto generado
PROJECT_DIR="$(pwd)"

# Nombre del proyecto (cookiecutter lo reemplaza antes de ejecutar este hook)
APP_NAME="{{ cookiecutter.project_name }}"
DEMO_NAME="${APP_NAME}Demo"

mv "$PROJECT_DIR/$APP_NAMEDemo" "$PROJECT_DIR/Demo/"

replace "ORGANIZATION" "{{ cookiecutter.company_name }}"
replace "com.company.PRODUCTNAME" "{{ cookiecutter.bundle_identifier }}"
