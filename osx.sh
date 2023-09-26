#!/opt/homebrew/bin/bash

: '
   Customizing macOS settings.
'

source ./lib.sh

print_header "MACOS CUSTOMIZER"

# Ask for sudo password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable .DS_Store file creation on network volumes
print_info "- disabling .DS_Store file creation..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# Disable the sound effects on boot
print_info "- disabling the sound effects on boot..."
sudo nvram StartupMute=%01

# Disable the “Are you sure you want to open this application?” dialog
print_info "- disabling the 'Are you sure you want to open this application?' dialog..."
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable auto-correct
print_info "- disabling auto-correct..."
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set ssh permissions
sudo chown -R "$USER:$USER" ~/.ssh
chmod -R 700 ~/.ssh
