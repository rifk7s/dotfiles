# Manual Configuration Setup

If you prefer not to use the automated `./install.sh` orchestrator, or if you only need to cherry-pick specific configurations, you can manually copy the dotfiles to their respective locations.

> [!NOTE]
> This is a **manual copy setup**, not using symlinks. You'll need to manually copy files when updating them in the repository.

### Prerequisites

```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Installation

1. **Clone this repository**
   ```bash
   git clone https://github.com/rifk7s/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
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

7. **Restore Claude Code memory (optional)**
   ```bash
   mkdir -p ~/.claude/projects/-Users-rifky-Desktop-alp-dueday/memory
   cp -r claude/memory/* ~/.claude/projects/-Users-rifky-Desktop-alp-dueday/memory/
   ```

8. **Reload shell**
   ```bash
   source ~/.zshrc
   ```

> [!TIP]
> After copying configs, restart your terminal or reload the shell for changes to take effect.
