#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_info "Evaluating Homebrew installation..."

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    log_info "Homebrew not found. Installing Homebrew..."
    execute env NONINTERACTIVE=1 /bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Configure path temporarily for this session
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    log_success "Homebrew is already installed."
fi

log_info "Updating Homebrew..."
execute brew update

log_info "Executing Homebrew bundle from Brewfile..."
if execute brew bundle --file="${DOTFILES_DIR}/Brewfile"; then
    log_success "Brew bundle completed successfully."
else
    log_error "Failed to execute brew bundle."
fi
