#!/bin/bash
set -e

cd scripts

step "Creando archivos demo..."
cd generate_demo.sh
step "Generando project..."
cd generate_project.sh
step "Generando archivos y package spm..."
cd generate_package_and_files.sh

success "Proyecto generado correctamente 🎉"
