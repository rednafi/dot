#!/usr/bin/env bash

: '
    Install Homebrew formulae and casks.
'

source ./lib.sh

# Formulae
FORMULAE=(
    bash
    curl
    gh
    git
    go
    htop
    hugo
    jq
    micro
    neofetch
    python@3.11
    shellcheck
    stow
    tree
    watch
    zsh
)

# Casks
CASKS=(
    "aldente"
    "font-jetbrains-mono"
    "visual-studio-code"
    "google-chrome"
)

# Install homebrew
function install_homebrew() {
  # URL for Homebrew installation script
  local brew_url="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

  # Check for Homebrew installation
  if ! command -v brew &> /dev/null; then
    print_info "- installing homebrew..."
    /bin/bash -c "$(curl -fsSL $brew_url)"
    print_info "- homebrew installed ✓"
  else
    print_info "- homebrew already installed ✓"
  fi
}

# Install a Homebrew formula/cask if not already installed
function brew_install() {
    if ! brew list "$1" &> /dev/null; then
        print_info "- installing $1..."
        brew install "$1"
        print_info "- $1 installed ✓"
    else
        print_info "- $1 is already installed ✓"
    fi
}

# Update and upgrade Homebrew
function brew_upgrade() {
    print_info "- upgrading Homebrew..."
    brew update && brew upgrade
    print_info "- homebrew upgraded ✓"
}

# Clean up Homebrew caches
function brew_cleanup() {
    print_info "- cleaning up Homebrew..."
    brew cleanup
    print_info "- homebrew cleaned up ✓"
}

##########################################
# Main
##########################################

print_header "HOMEBREW SCRIPT"

# Install Homebrew formulae
for formula in "${FORMULAE[@]}"; do
    brew_install "$formula"
done

# Install Homebrew casks
for cask in "${CASKS[@]}"; do
    brew_install "$cask" --cask
done

brew_upgrade
brew_cleanup
