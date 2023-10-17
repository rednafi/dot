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
    git-lfs
    go
    htop
    hugo
    jq
    micro
    neofetch
    parallel
    python@3.12
    shellcheck
    stow
    tree
    watch
    zsh
)

# Casks
CASKS=(
    "aldente"
    "visual-studio-code"
    "google-chrome"
)

FONTS=(
    "font-jetbrains-mono"
)

# Install homebrew
function install_homebrew() {
  # URL for Homebrew installation script
  local brew_url="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

  # Check for Homebrew installation
  if ! command -v brew &> /dev/null; then
    print_info "- installing homebrew..."
    /bin/bash -c "$(curl -fsSL "$brew_url")"
    print_info "- homebrew installed ✓"
  else
    print_info "- homebrew already installed ✓"
  fi
}

# Install a Homebrew formula/cask if not already installed
function brew_install() {
    local formula="$1"
    if ! brew list "$formula" &>/dev/null; then
        print_info "- Installing $formula..."
        if ! /opt/homebrew/bin/brew install "$formula" 2>&1 \
            | grep -q "already an App at"; then
            print_info "- $formula installed ✓"
        else
            print_info "- $formula is already installed ✓"
        fi
    else
        print_info "- $formula is already installed ✓"
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

install_homebrew

# Install Homebrew formulae
for formula in "${FORMULAE[@]}"; do
    brew_install "$formula"
done

# Install Homebrew casks
for cask in "${CASKS[@]}"; do
    brew_install "$cask" --cask
done

# Install Homebrew fonts
for font in "${FONTS[@]}"; do
    /opt/homebrew/bin/brew tap homebrew/cask-fonts
    brew_install "$font"
done

brew_upgrade
brew_cleanup
