#!/usr/bin/env bash
set -Eeuo pipefail

# ── Descubrir paths de forma robusta ───────────────────────────────────────────
# Este archivo está en: <repo-generado>/hooks/post_gen_project.sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"     # .../hooks
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"        # repo generado
SCRIPTS_DIR="$ROOT_DIR/scripts"                 # repo/scripts (recomendado)

# Logs útiles para depurar
echo "🧭 CWD:            $(pwd)"
echo "📄 SCRIPT_DIR:     $SCRIPT_DIR"
echo "📁 ROOT_DIR:       $ROOT_DIR"
echo "📁 SCRIPTS_DIR:    $SCRIPTS_DIR"

# ── Helpers inline (o movelos a scripts/00_lib.sh y 'source' allá) ────────────
step()    { echo -e "\n➡️  \033[1;34m$*\033[0m"; }
warn()    { echo -e "⚠️  \033[1;33m$*\033[0m"; }
success() { echo -e "✅ \033[1;32m$*\033[0m"; }
need_cmd(){ command -v "$1" >/dev/null || { warn "Falta comando: $1"; exit 1; }; }

# ── Verificaciones de existencia ──────────────────────────────────────────────
if [[ ! -d "$SCRIPTS_DIR" ]]; then
  warn "No existe $SCRIPTS_DIR"
  # Fallback: por si accidentalmente pusiste scripts dentro de hooks/
  if [[ -d "$SCRIPT_DIR/scripts" ]]; then
    SCRIPTS_DIR="$SCRIPT_DIR/scripts"
    echo "↪️  Usando fallback SCRIPTS_DIR=$SCRIPTS_DIR"
  else
    echo "Contenido del ROOT_DIR:"
    ls -la "$ROOT_DIR" || true
    echo
    echo "👉 Creá la carpeta 'scripts/' en la raíz del proyecto generado y colocá ahí tus scripts:"
    echo "   $ROOT_DIR/scripts/generate_demo.sh"
    echo "   $ROOT_DIR/scripts/generate_project.sh"
    echo "   $ROOT_DIR/scripts/generate_package_and_files.sh"
    exit 1
  fi
fi

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
