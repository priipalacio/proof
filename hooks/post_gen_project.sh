#!/bin/bash
set -e

# Ruta raíz del proyecto generado
PROJECT_DIR="../"


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
