#!/usr/bin/env bash

: '
    Run GNU stow to symlink dotfiles to the home directory.
'

source ./lib.sh

# Stow
STOW=(
    gh
    git
    shellcheck
    ssh
    ghostty
    zsh
    starship
)

print_header "DOTFILE STOWER"
print_info "- stowing config files..."
stow --verbose --restow --target ~ "${STOW[@]}"

print_info "- stowing scripts..."
sudo stow --verbose --restow --target /usr/local/bin bin

print_info "- permissions for scripts..."
find /usr/local/bin -type f -name "*.sh" -exec chmod +x {} +
