#!/usr/bin/env bash
# Quick system update script for Arch/Manjaro

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=_ui.sh
source "$SCRIPT_DIR/_ui.sh"

print_header "Mise à jour système"

print_info "Paquets officiels (pacman -Syu)"
sudo pacman -Syu --noconfirm
print_success "Paquets officiels à jour"

if command -v yay &>/dev/null; then
  print_info "Paquets AUR (yay)"
  yay -Syu --noconfirm
  print_success "AUR à jour"
elif command -v paru &>/dev/null; then
  print_info "Paquets AUR (paru)"
  paru -Syu --noconfirm
  print_success "AUR à jour"
else
  print_warning "Pas d'helper AUR (yay/paru)"
fi

print_info "Paquets orphelins"
mapfile -t orphans < <(pacman -Qtdq 2>/dev/null || true)
if (( ${#orphans[@]} > 0 )); then
  echo -e "  ${YELLOW}${#orphans[@]} paquet(s) :${NC} ${orphans[*]}"
  sudo pacman -Rns -- "${orphans[@]}"
  print_success "Orphelins retirés"
else
  print_success "Aucun orphelin"
fi

print_info "Cache des paquets (pacman -Sc)"
sudo pacman -Sc --noconfirm
print_success "Cache nettoyé"

print_done "Système à jour"
