# dotfiles

> Mes configurations personnelles pour un environnement de développement propre, moderne et reproductible.

![zsh](https://img.shields.io/badge/Shell-zsh-blueviolet)
![Manjaro](https://img.shields.io/badge/OS-Manjaro%20%2F%20Arch-orange)
![License](https://img.shields.io/badge/License-MIT-green)
![Stars](https://img.shields.io/github/stars/ledutheo/dotfiles?style=social)

---

## 🚀 Installation rapide

```bash
git clone git@github.com:ledutheo/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles
./install.sh
```

Redémarre ton terminal. C’est tout.

## ✨ Ce que ça installe

| Composant     | Cible                    | Ce que ça apporte                              |
|---------------|--------------------------|------------------------------------------------|
| **Zsh**       | `~/.zshrc`               | Aliases utiles + support des outils modernes  |
| **Git**       | `~/.gitconfig`           | Configuration pro + alias puissants           |
| **SSH**       | `~/.ssh/config`          | Multiplexing + optimisations de connexion     |
| **Scripts**   | `~/.local/bin/`          | Outils pratiques (mise à jour système, etc.)  |
| **Gitignore** | `~/.gitignore_global`    | Règles globales de base                       |

## 🛠 Outils recommandés (fortement)

Après l’installation, je te conseille d’installer ces outils modernes :

```bash
sudo pacman -S \
  zoxide \      # cd intelligent
  fzf \         # recherche floue ultra rapide
  bat \         # cat avec coloration syntaxique
  eza \         # ls moderne et beau
  starship \    # prompt magnifique et rapide
  ripgrep \     # grep ultra performant (rg)
  fd            # find moderne
```

Puis décommente la ligne Starship dans `zsh/.zshrc`.

## 📁 Structure du projet

```
dotfiles/
├── install.sh          # Script d’installation principal
├── README.md
├── zsh/
│   └── .zshrc
├── git/
│   └── .gitconfig
├── ssh/
│   └── config
├── scripts/            # Scripts utilitaires
├── docs/               # Documentation
└── .github/
```

## 💡 Philosophie

- **Simple mais puissant** — pas de sur-ingénierie
- Compatible avec la config Manjaro par défaut (je ne casse rien)
- Backups automatiques avant toute modification
- Facile à étendre et à comprendre dans 6 mois

## 🔧 Personnalisation

Tu veux ajouter des choses sans les committer ?

Crée simplement `~/.zshrc.local` — il sera sourcé automatiquement.

## 📜 Licence

MIT — tu peux copier, forker, t’inspirer librement.

## 👤 Auteur

**ledutheo** — [github.com/ledutheo](https://github.com/ledutheo)

---

*Ce dépôt évolue avec mon workflow. Il n’est pas figé.*
