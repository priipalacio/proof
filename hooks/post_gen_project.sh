#!/usr/bin/env bash
set -Eeuo pipefail

# Ubicar paths de forma robusta (independiente de dónde se ejecute)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPTS_DIR="$ROOT_DIR/scripts"

step()    { echo -e "\n➡️  \033[1;34m$*\033[0m"; }
success() { echo -e "✅ \033[1;32m$*\033[0m"; }
warn()    { echo -e "⚠️  \033[1;33m$*\033[0m"; }
need_cmd(){ command -v "$1" >/dev/null || { warn "Falta $1"; exit 1; }; }

step "Creando archivos demo..."
bash "$SCRIPTS_DIR/generate_demo.sh"

step "Generando project (XcodeGen)..."
bash "$SCRIPTS_DIR/generate_project.sh"

step "Generando archivos y package SPM..."
bash "$SCRIPTS_DIR/generate_package_and_files.sh"

success "Proyecto generado correctamente 🎉"
