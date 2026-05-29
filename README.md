# dotfiles

> Personal configuration files for a clean, powerful, and reproducible development environment.

![Shell](https://img.shields.io/badge/Shell-zsh-blue)
![OS](https://img.shields.io/badge/OS-Manjaro%20%2F%20Arch-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## Overview

This repository contains my personal dotfiles. It is designed to be:

- **Safe** — existing configurations are automatically backed up
- **Idempotent** — you can run the installer multiple times without issues
- **Modular** — easy to understand and extend
- **Modern** — includes quality-of-life improvements while staying compatible with Manjaro defaults

## Quick Start

```bash
# Clone the repository
git clone git@github.com:ledutheo/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the installer
./install.sh
```

Then restart your terminal.

## What Gets Installed

| Component     | Target                  | Description                              |
|---------------|-------------------------|------------------------------------------|
| Zsh           | `~/.zshrc`              | Enhanced shell with useful aliases & modern tools support |
| Git           | `~/.gitconfig`          | Professional defaults + powerful aliases |
| SSH           | `~/.ssh/config`         | Optimized SSH config with connection multiplexing |
| Scripts       | `~/.local/bin/`         | Useful utility scripts (update-system, etc.) |
| Gitignore     | `~/.gitignore_global`   | Global ignore rules                      |

## Recommended Tools

After installation, I highly recommend installing these modern CLI tools:

```bash
sudo pacman -S \
  zoxide \      # smarter cd
  fzf \         # fuzzy finder
  bat \         # better cat
  eza \         # better ls (or exa on older systems)
  starship \    # beautiful cross-shell prompt
  ripgrep \     # better grep (rg)
  fd            # better find
```

Then enable Starship by uncommenting the line in `zsh/.zshrc`.

## Project Structure

```
dotfiles/
├── install.sh          # Main installer (run this)
├── README.md
├── zsh/
│   └── .zshrc
├── git/
│   └── .gitconfig
├── ssh/
│   └── config
├── scripts/
│   └── update-system.sh
└── docs/
```

## Philosophy

- Keep it simple but powerful
- Prefer tools that are already in the Arch/Manjaro repositories when possible
- Never break the base Manjaro zsh experience
- Make the environment pleasant without requiring a full rewrite

## Customization

Want to add your own local overrides without committing them?

Create `~/.zshrc.local` — it will be automatically sourced.

## License

MIT — feel free to take inspiration or fork it.

## Author

**ledutheo** — [github.com/ledutheo](https://github.com/ledutheo)

---

*This repository is a living project. It will evolve as my workflow improves.*
