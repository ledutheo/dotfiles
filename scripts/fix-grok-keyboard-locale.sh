#!/usr/bin/env bash
# Répare locale UTF-8 (saisies bizarres dans Grok TUI et ailleurs)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=_ui.sh
source "$SCRIPT_DIR/_ui.sh"

print_header "Réparation locale UTF-8"

print_info "LANG actuel : ${LANG:-unset}"
print_info "charmap     : $(locale charmap 2>/dev/null || echo '?')"

print_info "Activation de fr_CH.UTF-8 dans /etc/locale.gen"
sudo sed -i 's/# fr_CH.UTF-8 UTF-8/fr_CH.UTF-8 UTF-8/' /etc/locale.gen || true

print_info "Génération des locales (10–20 s)"
sudo locale-gen

print_info "Défaut système : fr_CH.UTF-8"
echo 'LANG="fr_CH.UTF-8"' | sudo tee /etc/default/locale > /dev/null
echo 'LC_ALL="fr_CH.UTF-8"' | sudo tee -a /etc/default/locale > /dev/null

print_done "Locale configurée"
print_warning "Déconnecte-toi complètement (ou redémarre), puis reconnecte-toi."
echo "Vérifie avec :  locale charmap   (doit afficher UTF-8)"
echo "Ensuite relance grok et teste le clavier."
