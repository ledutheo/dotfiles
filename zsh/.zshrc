# ============================================
# ledutheo dotfiles - Zsh configuration
# ============================================

# --- Locale UTF-8 (évite les problèmes de clavier dans les TUI) ---
export LANG="${LANG:-fr_FR.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-fr_FR.UTF-8}"

# --- Manjaro base (complétion / raccourcis) ---
USE_POWERLINE="true"
HAS_WIDECHARS="false"

if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Prompt : Starship si dispo, sinon le prompt Manjaro
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
elif [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# --- Local tools (grok, scripts) ---
export PATH="$HOME/.local/node/bin:$HOME/.local/bin:$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh ~/.zfunc $fpath)
autoload -Uz compinit && compinit -C
zstyle ':completion:*' menu select

# ============================================
# History & navigation
# ============================================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt CORRECT

# ============================================
# Aliases
# ============================================

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias github='cd ~/github'
alias dots='cd ~/github/dotfiles'
alias 1975='cd ~/github/1975'
alias scripts='cd ~/github/scripts'

# Listing (eza si installé, sinon ls)
alias l='ls -lah --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lAh --color=auto'

# Git
alias gs='git status -s'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gca='git commit -am'
alias gp='git push'
alias gpl='git pull --rebase'
alias gl='git lg'
alias gla='git lga'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gb='git br'
alias gcb='git checkout -b'
alias gundo='git undo'
alias glast='git last'

# Scripts du quotidien (les vrais, pas pacman nu)
alias update='update-system.sh'
alias cleanup='cleanup.sh'
alias dots-up='dotfiles-update.sh'
alias locale-fix='fix-grok-keyboard-locale.sh'
alias orphans='pacman -Qtdq || echo "Aucun orphelin"'

# Pacman lecture
alias pss='pacman -Ss'
alias pqi='pacman -Qi'

# Sécurité
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Pratique
alias open='xdg-open'
alias ports='ss -tulpn'
alias showpath='print -l $path'
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias reload='source ~/.zshrc && echo "Zsh rechargé"'

# ============================================
# Outils modernes (si installés)
# ============================================

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

if command -v fzf &>/dev/null; then
  source <(fzf --zsh 2>/dev/null) 2>/dev/null || true
fi

if command -v bat &>/dev/null; then
  alias cat='bat --style=plain'
  alias catp='bat --paging=never'
fi

if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --group-directories-first'
  alias la='eza -lah --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons --group-directories-first'
elif command -v exa &>/dev/null; then
  alias ls='exa --icons --group-directories-first'
  alias ll='exa -lh --icons --group-directories-first'
  alias la='exa -lah --icons --group-directories-first'
fi

# ============================================
# Local overrides (pas commité)
# ============================================

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
export LIBVIRT_DEFAULT_URI=qemu:///system

# metavr shell completions
fpath=("/home/bill/.metavr/completions" $fpath)
autoload -Uz compinit && compinit
