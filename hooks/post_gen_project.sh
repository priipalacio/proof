#!/usr/bin/env bash
set -Eeuo pipefail

# ── Descubrir paths de forma robusta ───────────────────────────────────────────
# Este archivo está en: <repo-generado>/hooks/post_gen_project.sh
# Raíz del proyecto generado
ROOT_DIR="$(pwd)"
SCRIPT_DIR="$ROOT_DIR/hooks"

# Donde preferimos encontrar los scripts (dentro del proyecto generado)
CANDIDATES=(
  "$ROOT_DIR/scripts"           # si los copiás al proyecto generado
  "$ROOT_DIR/hooks/scripts"     # fallback por si los dejaste en hooks/scripts
  "$(cd "$ROOT_DIR/.." && pwd)/scripts"   # << tu caso: ../scripts (Utilities/scripts)
)

echo "🧭 CWD:            $ROOT_DIR"
echo "📄 SCRIPT_DIR:     $SCRIPT_DIR"

# ── Helpers inline (o movelos a scripts/00_lib.sh y 'source' allá) ────────────
step()    { echo -e "\n➡️  \033[1;34m$*\033[0m"; }
warn()    { echo -e "⚠️  \033[1;33m$*\033[0m"; }
success() { echo -e "✅ \033[1;32m$*\033[0m"; }
need_cmd(){ command -v "$1" >/dev/null || { warn "Falta comando: $1"; exit 1; }; }


# Asegurar permisos de ejecución para todos los scripts
chmod +x "$SCRIPTS_DIR/"*.sh 2>/dev/null || true

# ── Ejecución de pasos ────────────────────────────────────────────────────────
step "Creando archivos demo…"
bash "$SCRIPTS_DIR/generate_demo.sh"

step "Generando proyecto (XcodeGen)…"
bash "$SCRIPTS_DIR/generate_project.sh"

step "Generando Package y archivos…"
bash "$SCRIPTS_DIR/generate_package_and_files.sh"

success "Proyecto generado correctamente 🎉"
