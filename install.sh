#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Modular Dotfiles Orchestrator
# -----------------------------------------------------------------------------
# This is the main entry point. It assumes you have already cloned the repo
# using the git provided by Xcode Command Line Tools.
#
# Usage (on a fresh Mac):
# 1. xcode-select --install
# 2. git clone https://github.com/rifk7s/dotfiles.git ~/.dotfiles
# 3. cd ~/.dotfiles && ./install.sh
# -----------------------------------------------------------------------------

set -euo pipefail
IFS=$'\n\t'

export DRY_RUN=false
export VERBOSE=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--dry-run) DRY_RUN=true ;;
        -v|--verbose) VERBOSE=true ;;
        *) echo "Unknown parameter passed: $1" ;;
    esac
    shift
done

# Determine absolute path to dotfiles directory
export DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Output Formatting ---
export BOLD="$(tput bold 2>/dev/null || printf '')"
export GREEN="$(tput setaf 2 2>/dev/null || printf '')"
export BLUE="$(tput setaf 4 2>/dev/null || printf '')"
export RED="$(tput setaf 1 2>/dev/null || printf '')"
export YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
export RESET="$(tput sgr0 2>/dev/null || printf '')"

log_info() {
    printf "%s[INFO] %s%s\n" "${BLUE}" "$1" "${RESET}"
}
export -f log_info

log_success() {
    printf "%s[SUCCESS] %s%s\n" "${GREEN}${BOLD}" "$1" "${RESET}"
}
export -f log_success

log_warning() {
    printf "%s[WARNING] %s%s\n" "${YELLOW}" "$1" "${RESET}"
}
export -f log_warning

log_error() {
    printf "%s[ERROR] %s%s\n" "${RED}${BOLD}" "$1" "${RESET}" >&2
    exit 1
}
export -f log_error

execute() {
    if [[ "$DRY_RUN" == true ]]; then
        printf "%s[DRY-RUN]%s Would execute: %s\n" "${YELLOW}" "${RESET}" "$*" >&2
    else
        if [[ "$VERBOSE" == true ]]; then
            printf "%s[EXEC]%s %s\n" "${BLUE}" "${RESET}" "$*" >&2
        fi
        "$@"
    fi
}
export -f execute

# --- Pre-flight Checks ---
check_sudo() {
    if [[ "$DRY_RUN" == true ]]; then
        log_info "Skipping administrative privileges check (Dry Run)..."
        return
    fi
    log_info "Requesting administrative privileges..."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    log_success "Administrative privileges granted."
}

check_xcode() {
    log_info "Verifying Xcode Command Line Tools..."
    if ! xcode-select -p &>/dev/null; then
        log_error "Xcode CLI tools are not installed. Please run 'xcode-select --install' first."
    fi
    log_success "Xcode CLI tools verified."
}

print_banner() {
    clear
    printf "%s%s======================================================================%s\n" "${BLUE}" "${BOLD}" "${RESET}"
    printf "%s%s                 DOTFILES PROVISIONING SCRIPT                         %s\n" "${BLUE}" "${BOLD}" "${RESET}"
    printf "%s%s======================================================================%s\n" "${BLUE}" "${BOLD}" "${RESET}"
    echo ""
}
export -f print_banner

print_step() {
    local step=$1
    local title=$2
    local total=$3
    echo ""
    printf "%s%s----------------------------------------------------------------------%s\n" "${BLUE}" "${BOLD}" "${RESET}"
    printf "%s%s   STEP %s/%s: %s %s\n" "${BLUE}" "${BOLD}" "${step}" "${total}" "${title}" "${RESET}"
    printf "%s%s----------------------------------------------------------------------%s\n" "${BLUE}" "${BOLD}" "${RESET}"
    echo ""
    sleep 1
}
export -f print_step

# --- Main Execution ---
main() {
    print_banner
    log_info "Initializing setup sequence..."
    
    check_sudo
    check_xcode

    TOTAL_STEPS=4

    print_step "1" "macOS Configuration" "${TOTAL_STEPS}"
    log_info "Applying hidden settings and UI tweaks..."
    source "${DOTFILES_DIR}/setup/macos.sh"
    log_success "macOS Configuration finished."

    print_step "2" "Homebrew & Packages" "${TOTAL_STEPS}"
    log_info "Installing binaries, casks, and fonts..."
    source "${DOTFILES_DIR}/setup/homebrew.sh"
    log_success "Homebrew packages installed."

    print_step "3" "Manual App Installations" "${TOTAL_STEPS}"
    log_info "Checking apps outside of Homebrew..."
    source "${DOTFILES_DIR}/setup/manual_apps.sh"
    log_success "Manual apps phase finished."

    print_step "4" "Symlinking Configs" "${TOTAL_STEPS}"
    log_info "Mapping configuration files to home directory..."
    source "${DOTFILES_DIR}/setup/symlinks.sh"
    log_success "Symlinks generated."

    echo ""
    printf "%s%s======================================================================%s\n" "${GREEN}" "${BOLD}" "${RESET}"
    printf "%s%s    [OK] INSTALLATION COMPLETE! A system reboot is highly recommended.  %s\n" "${GREEN}" "${BOLD}" "${RESET}"
    printf "%s%s======================================================================%s\n" "${GREEN}" "${BOLD}" "${RESET}"
    echo ""
}

# The main call already passes "$@" from the top but we shifted them. 
# We don't need to pass "$@" to main if we already processed them, but let's just call main.
main
