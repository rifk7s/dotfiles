#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_info "Deploying Configuration Symlinks..."
echo ""
printf "%s%s======================================================================%s\n" "${YELLOW}" "${BOLD}" "${RESET}"
printf "%s%s                 SMART SYMLINK MANAGER                                %s\n" "${YELLOW}" "${BOLD}" "${RESET}"
printf "%s%s======================================================================%s\n" "${YELLOW}" "${BOLD}" "${RESET}"

# Helper function to smartly symlink files/directories
smart_symlink() {
    local source_file="$1"
    local target_file="$2"
    local app_name="$3" # Optional, to check if app is installed first
    local friendly_name="$4" # Name to display in logs
    
    # If an app name is provided, check if it's installed (either in /Applications, or via CLI)
    if [[ -n "$app_name" ]]; then
        if [[ ! -d "/Applications/${app_name}.app" ]] && [[ ! -d "${HOME}/Applications/${app_name}.app" ]] && [[ ! -d "/System/Applications/${app_name}.app" ]] && ! command -v "${app_name}" &>/dev/null; then
            printf "  %s[SKIP]%s %-15s : App not installed, skipping config.\n" "${YELLOW}" "${RESET}" "${friendly_name}"
            return
        fi
    fi

    # Ensure parent directory of target exists
    mkdir -p "$(dirname "$target_file")"

    if [[ -L "$target_file" ]]; then
        if [[ "$(readlink "$target_file")" == "$source_file" ]]; then
            printf "  %s[OK]%s   %-15s : Already perfectly symlinked.\n" "${GREEN}" "${RESET}" "${friendly_name}"
            return
        else
            printf "  %s[WARN]%s %-15s : Symlink points elsewhere. Overwriting...\n" "${YELLOW}" "${RESET}" "${friendly_name}"
            rm -f "$target_file"
        fi
    elif [[ -e "$target_file" ]]; then
        printf "  %s[BACKUP]%s %-13s : Real file found. Backing up to .bak...\n" "${BLUE}" "${RESET}" "${friendly_name}"
        mv "$target_file" "${target_file}.bak"
    fi

    ln -snf "$source_file" "$target_file"
    printf "  %s[LINKED]%s %-13s : Successfully symlinked!\n" "${GREEN}" "${RESET}" "${friendly_name}"
}

printf "%s%s[ CORE SHELL ]:%s\n" "${BLUE}" "${BOLD}" "${RESET}"
smart_symlink "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc" "" "zshrc"
smart_symlink "${DOTFILES_DIR}/.zprofile" "${HOME}/.zprofile" "" "zprofile"
smart_symlink "${DOTFILES_DIR}/.zshenv" "${HOME}/.zshenv" "" "zshenv"
smart_symlink "${DOTFILES_DIR}/starship.toml" "${HOME}/.config/starship.toml" "starship" "starship"
echo ""

printf "%s%s[ TERMINAL & EDITORS ]:%s\n" "${BLUE}" "${BOLD}" "${RESET}"
smart_symlink "${DOTFILES_DIR}/ghostty/config" "${HOME}/Library/Application Support/com.mitchellh.ghostty/config" "Ghostty" "Ghostty"
printf "  %s?%s VS Code has native 'Settings Sync'. Symlink local configs anyway? [y/N]: " "${YELLOW}" "${RESET}"
read -r vscode_response
if [[ "$vscode_response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    smart_symlink "${DOTFILES_DIR}/vscode/settings.json" "${HOME}/Library/Application Support/Code/User/settings.json" "Visual Studio Code" "VS Code Settings"
    smart_symlink "${DOTFILES_DIR}/vscode/keybindings.json" "${HOME}/Library/Application Support/Code/User/keybindings.json" "Visual Studio Code" "VS Code Keys"
else
    printf "  %s[SKIP]%s VS Code settings skipped to avoid Settings Sync conflicts.\n" "${YELLOW}" "${RESET}"
fi
echo ""

printf "%s%s[ SYSTEM TOOLS ]:%s\n" "${BLUE}" "${BOLD}" "${RESET}"
smart_symlink "${DOTFILES_DIR}/btop" "${HOME}/.config/btop" "btop" "btop"
smart_symlink "${DOTFILES_DIR}/fastfetch" "${HOME}/.config/fastfetch" "fastfetch" "fastfetch"
echo ""

printf "%s%s[ CLAUDE CODE ]:%s\n" "${BLUE}" "${BOLD}" "${RESET}"
smart_symlink "${DOTFILES_DIR}/claude/settings.json" "${HOME}/.claude/settings.json" "claude" "Claude Settings"
smart_symlink "${DOTFILES_DIR}/claude/claude-powerline.json" "${HOME}/.claude/claude-powerline.json" "claude" "Claude Powerline"
echo ""

printf "%s%s----------------------------------------------------------------------%s\n" "${YELLOW}" "${BOLD}" "${RESET}"
echo ""
