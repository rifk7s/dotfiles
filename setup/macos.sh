#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_info "Configuring macOS default settings..."

# Close any open System Preferences panes, to prevent them from overriding settings
execute osascript -e 'tell application "System Preferences" to quit' || true

# --- Finder ---
log_info "Configuring Finder..."
execute defaults write com.apple.finder AppleShowAllFiles -bool true
execute defaults write com.apple.finder ShowPathbar -bool true
execute defaults write com.apple.finder ShowStatusBar -bool true
execute defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# --- Dock ---
log_info "Configuring Dock..."
execute defaults write com.apple.dock autohide -bool true
execute defaults write com.apple.dock show-recents -bool false

# --- General System ---
log_info "Configuring General System UI..."
# Disable press-and-hold for keys in favor of key repeat
execute defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
execute defaults write NSGlobalDomain KeyRepeat -int 1
execute defaults write NSGlobalDomain InitialKeyRepeat -int 10

log_success "macOS configuration applied. (Some changes require a restart to take effect)."
