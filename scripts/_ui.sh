#!/usr/bin/env bash
# Couleurs partagées par les scripts dotfiles. Ne pas lancer tout seul.

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
  echo -e "\n${CYAN}════════════════════════════════════════════════════${NC}"
  echo -e "${CYAN}  $1${NC}"
  echo -e "${CYAN}════════════════════════════════════════════════════${NC}\n"
}

print_success() { echo -e "${GREEN}✔${NC} $1"; }
print_info()    { echo -e "${BLUE}→${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error()   { echo -e "${RED}✖${NC} $1"; }

print_done() {
  echo -e "\n${GREEN}════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}  $1${NC}"
  echo -e "${GREEN}════════════════════════════════════════════════════${NC}\n"
}
