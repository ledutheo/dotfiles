#!/usr/bin/env bash
# Update your dotfiles from GitHub

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=_ui.sh
source "$SCRIPT_DIR/_ui.sh"

DOTFILES_DIR="$HOME/github/dotfiles"

print_header "Mise à jour des dotfiles"

if [[ ! -d "$DOTFILES_DIR" ]]; then
  print_error "$DOTFILES_DIR n'existe pas"
  echo "Clone d'abord : git clone git@github.com:ledutheo/dotfiles.git ~/github/dotfiles"
  exit 1
fi

cd "$DOTFILES_DIR"

print_info "git pull --rebase"
git pull --rebase
print_success "Dépôt à jour"

print_info "Réinstallation des liens"
./install.sh

print_done "Dotfiles à jour"
