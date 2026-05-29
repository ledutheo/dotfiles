#!/usr/bin/env bash
#
# ledutheo dotfiles - Installer
# Version améliorée avec couleurs et meilleure UX
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$BACKUP_DIR/install.log"

print_header() {
  echo -e "\n${CYAN}════════════════════════════════════════════════════${NC}"
  echo -e "${CYAN}  ledutheo dotfiles installer${NC}"
  echo -e "${CYAN}════════════════════════════════════════════════════${NC}\n"
}

print_success() { echo -e "${GREEN}✔${NC} $1"; }
print_info()    { echo -e "${BLUE}→${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error()   { echo -e "${RED}✖${NC} $1"; }

print_header

echo -e "Source : ${BLUE}$DOTFILES_DIR${NC}"
echo -e "Backups: ${BLUE}$BACKUP_DIR${NC}\n"

mkdir -p "$BACKUP_DIR"
touch "$LOG_FILE"

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    print_warning "Backup: $target"
    mv "$target" "$BACKUP_DIR/" 2>> "$LOG_FILE"
  fi
}

create_symlink() {
  local src="$1"
  local dest="$2"

  backup_if_exists "$dest"
  ln -s "$src" "$dest"
  print_success "Linked: $dest"
}

# ============================================
# Installation
# ============================================

echo -e "${YELLOW}Installation des configurations...${NC}\n"

# --- Zsh ---
print_info "[zsh]"
create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# --- Git ---
print_info "[git]"
create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

if [[ ! -f "$HOME/.gitignore_global" ]]; then
  cat > "$HOME/.gitignore_global" << 'EOF'
# Global Git Ignore - ledutheo
.DS_Store
Thumbs.db
*.swp
*~
.idea/
.vscode/
*.log
.env
.env.local
EOF
  print_success "Created: ~/.gitignore_global"
fi

# --- SSH ---
print_info "[ssh]"
mkdir -p "$HOME/.ssh/sockets"
chmod 700 "$HOME/.ssh" "$HOME/.ssh/sockets" 2>/dev/null || true
create_symlink "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config" 2>/dev/null || true

# --- Scripts ---
print_info "[scripts]"
mkdir -p "$HOME/.local/bin"

for script in "$DOTFILES_DIR/scripts"/*.sh; do
  [[ -f "$script" ]] || continue
  name=$(basename "$script")
  create_symlink "$script" "$HOME/.local/bin/${name}"
  chmod +x "$HOME/.local/bin/${name}"
done

# ============================================
# Final
# ============================================

echo -e "\n${GREEN}════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Installation terminée avec succès !${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════${NC}\n"

echo -e "Backups sauvegardés dans : ${BLUE}$BACKUP_DIR${NC}"
echo -e "\nProchaines étapes :"
echo -e "  1. Redémarre ton terminal ou exécute : ${CYAN}source ~/.zshrc${NC}"
echo -e "  2. Installe les outils recommandés (voir README)"
echo -e "  3. Profite d'un shell plus agréable\n"

print_success "Bonne journée !"
