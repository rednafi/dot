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
    term
    zsh
)

print_header "DOTFILE STOWER"
print_info "- stowing config files..."
stow -v -R -t ~ "${STOW[@]}"

mkdir -p ~/.config/fish
stow -v -R -t ~/.config/fish "fish"
