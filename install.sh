#!/usr/bin/env bash
#
# ledutheo dotfiles installer
# Usage:
#   ./install.sh
#
# This script sets up symlinks for your dotfiles.
# It is safe to run multiple times.
#

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

echo "==> ledutheo dotfiles installer"
echo "    Source: $DOTFILES_DIR"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    echo "    Backing up: $target → $BACKUP_DIR/"
    mv "$target" "$BACKUP_DIR/"
  fi
}

link_file() {
  local src="$1"
  local dest="$2"

  backup_if_exists "$dest"
  ln -s "$src" "$dest"
  echo "    Linked: $dest → $src"
}

echo "==> Installing configurations..."

# --- Zsh ---
echo "[zsh]"
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# --- Git ---
echo "[git]"
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Create global gitignore if it doesn't exist
if [[ ! -f "$HOME/.gitignore_global" ]]; then
  cat > "$HOME/.gitignore_global" << 'EOF'
# Global gitignore - ledutheo dotfiles
.DS_Store
Thumbs.db
*.swp
*.swo
*~
.idea/
.vscode/
*.log
.env
.env.local
EOF
  echo "    Created: ~/.gitignore_global"
fi

# --- SSH ---
echo "[ssh]"
mkdir -p "$HOME/.ssh/sockets"
chmod 700 "$HOME/.ssh"
chmod 700 "$HOME/.ssh/sockets"

link_file "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# --- Scripts ---
echo "[scripts]"
mkdir -p "$HOME/.local/bin"

for script in "$DOTFILES_DIR/scripts"/*.sh; do
  if [[ -f "$script" ]]; then
    name=$(basename "$script")
    link_file "$script" "$HOME/.local/bin/${name}"
    chmod +x "$HOME/.local/bin/${name}"
  fi
done

echo ""
echo "==> Installation complete!"
echo ""
echo "Backups were saved in: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. (Optional but recommended) Install modern tools:"
echo "       sudo pacman -S zoxide fzf bat eza starship"
echo "  3. Enjoy a better shell experience."
echo ""
echo "To uninstall / restore backups, check the backup folder above."
