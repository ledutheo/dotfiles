# Architecture & Design Decisions

This document explains the choices made in this dotfiles repository.

## Why this structure?

- **One folder per concern** (`zsh/`, `git/`, `ssh/`)
  - Makes it obvious what each piece does
  - Easy to enable/disable parts

- **Symlinking via `install.sh`**
  - Simple to understand
  - No external dependency required at first (though GNU Stow is recommended for advanced users later)

- **Automatic backups**
  - The installer never silently destroys your existing configuration

## Why not GNU Stow by default?

Stow is excellent, but adds a dependency and mental overhead for beginners.
The current installer is deliberately simple while still being safe.

Advanced users can easily switch to Stow later.

## Git Configuration Choices

- `pull.rebase = true` → cleaner history
- `push.autoSetupRemote = true` → less typing
- Strong alias set (`lg`, `s`, `undo`, etc.)

## Shell Philosophy

We deliberately keep the Manjaro base configuration because:
- It already provides a good prompt and completion
- We only layer useful additions on top
- This reduces the risk of breaking things after system updates

## Future Improvements

Possible additions (when needed):
- Neovim configuration
- Starship prompt as default
- Tmux / Wezterm configs
- Container / Kubernetes helpers

Contributions and suggestions are welcome via issues or pull requests.
