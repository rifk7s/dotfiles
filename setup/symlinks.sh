#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_info "Setting up symlinks..."

# If we are using GNU Stow (which we installed via Brewfile)
if command -v stow &>/dev/null; then
    log_info "GNU Stow found. You can place your configs in directories (e.g. nvim/ zsh/) here and run:"
    log_info "cd ${DOTFILES_DIR} && stow nvim"
else
    log_warning "Stow not installed yet or not found in PATH."
fi

# Example manual symlink:
# ln -sf "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"

log_success "Symlinks setup complete."
