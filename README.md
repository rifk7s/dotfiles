# Dotfiles


[![Ghostty](https://img.shields.io/badge/Ghostty-Terminal-6366f1?style=flat&logoColor=white&labelColor=6366f1&color=6c757d)](https://ghostty.org/)
[![Zsh](https://img.shields.io/badge/Zsh-Shell-1A2C34?style=flat&logo=gnu-bash&logoColor=white&labelColor=1A2C34&color=6c757d)](https://www.zsh.org/)
[![Starship](https://img.shields.io/badge/Starship-Prompt-DD0B78?style=flat&logoColor=white&labelColor=DD0B78&color=6c757d)](https://starship.rs/)
[![VS Code](https://img.shields.io/badge/VS_Code-Editor-007ACC?style=flat&logo=visualstudiocode&logoColor=white&labelColor=007ACC&color=6c757d)](https://code.visualstudio.com/)
[![Homebrew](https://img.shields.io/badge/Homebrew-Package_Manager-FBB040?style=flat&logo=homebrew&logoColor=black&labelColor=FBB040&color=6c757d)](https://brew.sh/)
[![Claude Code](https://img.shields.io/badge/Claude_Code-AI_Assistant-D97706?style=flat&logo=anthropic&logoColor=white&labelColor=D97706&color=6c757d)](https://claude.ai/)

<div align="center">
  <img src="images.png" alt="Ghostty Terminal Setup" />
</div>

My personal macOS configuration files and settings.

## Core Tools

**Terminal & Shell:** Ghostty, Zsh, Starship Prompt
**Development:** VS Code, Claude Code

## System

**Monitoring:** btop, fastfetch  
**Package Manager:** Homebrew


## Quick Start

> [!NOTE]
> This is a **manual copy setup**, not using symlinks. You'll need to manually copy files when updating.

### Prerequisites

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installation

1. **Clone this repository**
   ```bash
   git clone https://github.com/rifk7s/dotfiles.git
   cd dotfiles
   ```

2. **Copy shell configurations**
   ```bash
   cp .zshrc ~/.zshrc
   cp .zprofile ~/.zprofile
   cp .zshenv ~/.zshenv
   cp starship.toml ~/.config/starship.toml
   ```

3. **Copy Ghostty configuration**
   ```bash
   mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
   cp ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config
   ```

4. **Copy VS Code settings**
   ```bash
   cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
   cp vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
   ```

5. **Copy other tool configs**
   ```bash
   cp -r btop ~/.config/btop
   cp -r fastfetch ~/.config/fastfetch
   ```

6. **Copy Claude Code settings**
   ```bash
   mkdir -p ~/.claude
   cp claude/settings.json ~/.claude/settings.json
   cp claude/claude-powerline.json ~/.claude/claude-powerline.json
   ```

   > [!CAUTION]
   > Before using, edit `~/.claude/settings.json` to add your own API key or remove the `apiKeyHelper` field.

7. **Reload shell**
   ```bash
   source ~/.zshrc
   ```

> [!TIP]
> After copying configs, restart your terminal or reload the shell for changes to take effect.

## Features

### Ghostty Terminal
- **Theme:** Catppuccin Mocha
- **Font:** JetBrainsMono Nerd Font (16pt)
- **Background:** Blur effect with 75% opacity
- **Shell Integration:** Full SSH support with terminfo auto-install
- **Custom Shaders:** Not included in this repo (personal preference)

> [!NOTE]
> Ghostty shaders are stored locally and not synced to this repo. If you want to use custom shaders, check out [hackrmomo/ghostty-shaders](https://github.com/hackrmomo/ghostty-shaders) for examples.

### Zsh Configuration
- Homebrew integration
- Python 3.14 PATH setup
- uv (Python package installer) PATH
- Custom aliases and functions

### Starship Prompt
- Modern, fast, and customizable prompt
- Git status integration
- Language version indicators
- Execution time display

### VS Code
- Moonlight II theme
- Fluent Icons
- Custom keybindings
- Enhanced editor settings

### Claude Code
- Custom API configuration
- Powerline status line with rose-pine theme
- Plugins: frontend-design, context7, code-simplifier, superpowers
- Always thinking mode enabled
- Model preferences configured

> [!NOTE]
> The `claude/settings.json` in this repo has sensitive fields redacted. You must configure your own API key after copying.

## Package Lists

> [!IMPORTANT]
> Package lists are for reference only. Review packages before mass installation.

The `packages/` directory contains lists of installed packages:
- **brew-packages.txt** - Homebrew formulae
- **brew-cask.txt** - Homebrew casks (apps)
- **npm-packages.txt** - npm global packages

To export your current packages:

```bash
# Export Homebrew packages
brew leaves > packages/brew-packages.txt
brew list --cask > packages/brew-cask.txt

# Export npm packages
npm list -g --depth=0 > packages/npm-packages.txt
```

## Customization

### Changing Ghostty Theme

Edit `ghostty/config`:
```bash
# Available themes: Catppuccin Mocha, Catppuccin Latte, Vesper, etc.
theme = Catppuccin Mocha
```

### Changing Starship Prompt

Edit `starship.toml` to customize your prompt. See [Starship documentation](https://starship.rs/config/) for options.

### Adding VS Code Extensions

Export your current extensions:
```bash
code --list-extensions > vscode/extensions.txt
```

## Troubleshooting

> [!WARNING]
> Common issues and their solutions are listed below.

### Shell not loading configs

```bash
# Make sure files are in the right location
ls -la ~/ | grep "^\.zsh"

# Reload shell
source ~/.zshrc
```

### Ghostty config not applied

```bash
# Check config location
ls -la ~/Library/Application\ Support/com.mitchellh.ghostty/

# Reload Ghostty config
# Press: super+r (or cmd+r)
```

### Starship prompt not showing

```bash
# Make sure starship is installed
brew install starship

# Check if it's in .zshrc
grep starship ~/.zshrc
```

## Notes

> [!NOTE]
> These dotfiles are configured for **macOS**. Some paths and configs may need adjustment for Linux.

- Configs are periodically updated as I refine my setup
- Not all configs may work out-of-the-box on your system
- Feedback and suggestions are welcome

