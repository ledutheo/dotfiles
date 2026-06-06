# ============================================
# ledutheo dotfiles - Zsh configuration
# ============================================

# --- Locale UTF-8 (évite les problèmes de clavier dans les TUI) ---
export LANG="${LANG:-fr_FR.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-fr_FR.UTF-8}"

# --- Manjaro base configuration ---
USE_POWERLINE="true"
HAS_WIDECHARS="false"

if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# --- Local tools (syskit, grok, scripts) ---
export PATH="$HOME/.local/bin:$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C

# ============================================
# Modern Developer Quality of Life
# ============================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Better directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Correction
setopt CORRECT

# ============================================
# Useful Aliases
# ============================================

# Navigation & listing
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias l='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lAh --color=auto'

# Git (short & powerful)
alias gs='git status -s'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit -am'
alias gp='git push'
alias gpl='git pull'
alias gl='git lg'
alias gla='git lga'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gb='git branch'
alias gcb='git checkout -b'

# System
alias update='sudo pacman -Syu'
alias orphans='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No orphans to remove"'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick edit
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias reload='source ~/.zshrc && echo "Zsh reloaded"'

# ============================================
# Modern Tools (if installed)
# ============================================

# zoxide (smarter cd)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# fzf (fuzzy finder)
if command -v fzf &>/dev/null; then
  source <(fzf --zsh 2>/dev/null || fzf --fish 2>/dev/null) 2>/dev/null || true
fi

# bat (better cat)
if command -v bat &>/dev/null; then
  alias cat='bat --style=plain'
  alias catp='bat --paging=never'
fi

# eza (better ls) - fallback to exa on older systems
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --group-directories-first'
  alias la='eza -lah --icons --group-directories-first'
elif command -v exa &>/dev/null; then
  alias ls='exa --icons --group-directories-first'
  alias ll='exa -lh --icons --group-directories-first'
fi

# ============================================
# Prompt enhancement (optional)
# ============================================

# If you install starship later, uncomment:
# eval "$(starship init zsh)"

# ============================================
# Local overrides (not committed)
# ============================================

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
