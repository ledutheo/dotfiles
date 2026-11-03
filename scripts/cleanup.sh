#!/usr/bin/env bash
# Quick system cleanup for Arch/Manjaro

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=_ui.sh
source "$SCRIPT_DIR/_ui.sh"

print_header "Nettoyage système"

print_info "Cache pacman"
sudo pacman -Sc --noconfirm
print_success "Cache pacman nettoyé"

print_info "Journaux de plus de 2 semaines"
sudo journalctl --vacuum-time=2weeks
print_success "Journaux vacuum"

print_info "Cache utilisateur (miniatures, Firefox)"
rm -rf ~/.cache/thumbnails/* 2>/dev/null || true
rm -rf ~/.cache/mozilla/firefox/*/cache2 2>/dev/null || true
print_success "Cache utilisateur nettoyé"

if command -v du &>/dev/null; then
  cache_size="$(du -sh ~/.cache 2>/dev/null | cut -f1 || true)"
  [[ -n "$cache_size" ]] && print_info "Taille actuelle de ~/.cache : ${cache_size}"
fi

print_done "Nettoyage terminé"
