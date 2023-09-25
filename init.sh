#!/bin/bash

# Set shell options for safety and clarity
set -euo pipefail

# Define some colors for output
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Formulae
FORMULAE=(
    bash
    curl
    gh
    git
    go
    htop
    jq
    micro
    neofetch
    python@3.11
    stow
    zsh
)

# Casks
CASKS=(
    "aldente"
    "font-jetbrains-mono"
    "visual-studio-code"
    "firefox"
    "google-chrome"
)

# Stow
STOW=(
    git
    ssh
    term
    zsh
)

# Print a header section
function print_header() {
    echo -e "${CYAN}-----------${RESET}"
    echo -e "${CYAN}INIT SCRIPT${RESET}"
    echo -e "${CYAN}-----------${RESET}"
    echo
}

# Print an info message
function print_info() {
    echo -e "${GREEN}$1${RESET}"
}

# Install a Homebrew formula if not already installed
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

# Print header
print_header

# Check for Homebrew installation
if ! command -v brew &> /dev/null; then
    print_info "- installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    print_info "- homebrew installed ✓"
else
    print_info "- homebrew already installed ✓"
fi

# Install Homebrew formulae
for formula in "${FORMULAE[@]}"; do
    brew_install "$formula"
done

# Install Homebrew casks
for cask in "${CASKS[@]}"; do
    brew_install "$cask" --cask
done

# Upgrade and clean up Homebrew
brew_upgrade
brew_cleanup

# Stow dotfiles
print_info "- stowing config files..."
stow -v -R -t ~ "${STOW[@]}"

# Stop .DS_Store files from being created
print_info "- disabling .DS_store files..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

print_info "- Done!"
