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
export FMT_BOLD="$(tput bold 2>/dev/null || printf '')"
export FMT_GREEN="$(tput setaf 2 2>/dev/null || printf '')"
export FMT_BLUE="$(tput setaf 4 2>/dev/null || printf '')"
export FMT_RED="$(tput setaf 1 2>/dev/null || printf '')"
export FMT_YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
export FMT_RESET="$(tput sgr0 2>/dev/null || printf '')"

log_info() {
    if command -v gum &>/dev/null; then
        gum style --foreground 212 "ℹ $1"
    else
        printf "%s[INFO] %s%s\n" "${FMT_BLUE}" "$1" "${FMT_RESET}"
    fi
}
export -f log_info

log_success() {
    if command -v gum &>/dev/null; then
        gum style --foreground 46 --bold "✔ $1"
    else
        printf "%s[SUCCESS] %s%s\n" "${FMT_GREEN}${FMT_BOLD}" "$1" "${FMT_RESET}"
    fi
}
export -f log_success

log_warning() {
    if command -v gum &>/dev/null; then
        gum style --foreground 220 "⚠ $1"
    else
        printf "%s[WARNING] %s%s\n" "${FMT_YELLOW}" "$1" "${FMT_RESET}"
    fi
}
export -f log_warning

log_error() {
    if command -v gum &>/dev/null; then
        gum style --foreground 196 --bold "✖ $1" >&2
    else
        printf "%s[ERROR] %s%s\n" "${FMT_RED}${FMT_BOLD}" "$1" "${FMT_RESET}" >&2
    fi
    exit 1
}
export -f log_error

execute() {
    if [[ "$DRY_RUN" == true ]]; then
        printf "%s[DRY-RUN]%s Would execute: %s\n" "${FMT_YELLOW}" "${FMT_RESET}" "$*" >&2
    else
        if [[ "$VERBOSE" == true ]]; then
            printf "%s[EXEC]%s %s\n" "${FMT_BLUE}" "${FMT_RESET}" "$*" >&2
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
    if command -v gum &>/dev/null; then
        gum style \
            --foreground 212 --border-foreground 212 --border double \
            --align center --width 50 --margin "1 2" --padding "1 2" \
            "DOTFILES PROVISIONING" "by rifk7s"
    else
        printf "%s%s======================================================================%s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}"
        printf "%s%s                 DOTFILES PROVISIONING SCRIPT                         %s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}"
        printf "%s%s======================================================================%s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}"
        echo ""
    fi
}
export -f print_banner

print_step() {
    local step=$1
    local title=$2
    local total=$3
    echo ""
    if command -v gum &>/dev/null; then
        gum style \
            --foreground 212 --bold \
            "▶ STEP $step/$total: $title"
    else
        printf "%s%s----------------------------------------------------------------------%s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}"
        printf "%s%s   STEP %s/%s: %s %s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${step}" "${total}" "${title}" "${FMT_RESET}"
        printf "%s%s----------------------------------------------------------------------%s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}"
    fi
    echo ""
    sleep 1
}
export -f print_step

# --- Main Execution ---
ensure_gum() {
    if ! command -v gum &>/dev/null; then
        echo "Installing 'gum' (interactive UI toolkit)..."
        if ! command -v brew &>/dev/null; then
            NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
        fi
        brew install gum
    fi
}

main() {
    ensure_gum
    print_banner

    if [[ "$DRY_RUN" == true ]]; then
        if command -v gum &>/dev/null; then
            gum style --foreground 220 --border normal --padding "0 1" "DRY RUN MODE ENABLED - No changes will be made"
        else
            echo "[DRY RUN MODE ENABLED - No changes will be made]"
        fi
    fi

    log_info "Initializing setup sequence..."
    check_sudo
    check_xcode

    TOTAL_STEPS=4

    local choice
    if command -v gum &>/dev/null; then
        gum style --foreground 212 "What would you like to do?"
        choice=$(gum choose "Full Installation (Recommended)" "1. macOS Configuration" "2. Homebrew & Packages" "3. Manual Apps Audit" "4. Symlinks Setup" "Quit")
    else
        choice="Full Installation (Recommended)"
    fi

    case "$choice" in
        "Quit")
            log_info "Aborting setup."
            exit 0
            ;;
        "1. macOS Configuration")
            print_step "1" "macOS Configuration" "1"
            source "${DOTFILES_DIR}/setup/macos.sh"
            ;;
        "2. Homebrew & Packages")
            print_step "1" "Homebrew & Packages" "1"
            source "${DOTFILES_DIR}/setup/homebrew.sh"
            ;;
        "3. Manual Apps Audit")
            print_step "1" "Manual Apps Audit" "1"
            source "${DOTFILES_DIR}/setup/manual_apps.sh"
            ;;
        "4. Symlinks Setup")
            print_step "1" "Symlinking Configs" "1"
            source "${DOTFILES_DIR}/setup/symlinks.sh"
            ;;
        *)
            print_step "1" "macOS Configuration" "${TOTAL_STEPS}"
            source "${DOTFILES_DIR}/setup/macos.sh"
            
            print_step "2" "Homebrew & Packages" "${TOTAL_STEPS}"
            source "${DOTFILES_DIR}/setup/homebrew.sh"
            
            print_step "3" "Manual Apps Audit" "${TOTAL_STEPS}"
            source "${DOTFILES_DIR}/setup/manual_apps.sh"
            
            print_step "4" "Symlinking Configs" "${TOTAL_STEPS}"
            source "${DOTFILES_DIR}/setup/symlinks.sh"
            ;;
    esac

    echo ""
    if command -v gum &>/dev/null; then
        gum style --foreground 46 --border normal --padding "1 2" "INSTALLATION COMPLETE! A system reboot is highly recommended."
    else
        printf "%s%s======================================================================%s\n" "${GREEN}" "${BOLD}" "${RESET}"
        printf "%s%s    [OK] INSTALLATION COMPLETE! A system reboot is highly recommended.  %s\n" "${GREEN}" "${BOLD}" "${RESET}"
        printf "%s%s======================================================================%s\n" "${GREEN}" "${BOLD}" "${RESET}"
    fi
    echo ""
}

# The main call already passes "$@" from the top but we shifted them. 
# We don't need to pass "$@" to main if we already processed them, but let's just call main.
main
