#!/usr/bin/env bash
set -e


echo "➡️  Creando archivos demo..."
bash ./scripts/generate_demo.sh

echo "➡️  Generando proyecto..."
bash ./scripts/generate_project.sh

echo "➡️  Generando Package y archivos..."
bash ./scripts/generate_package_and_files.sh

echo "✅ Proyecto generado correctamente"
