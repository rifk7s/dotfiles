# Clean Install Reference

Apps and tools to reinstall after a clean macOS install.

## CLI Tools (curl/standalone)

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Claude Code
curl -fsSL https://claude.ai/install.sh | sh

# uv (Python)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Antigravity CLI
# check: https://antigravity.dev or install docs

# OpenCode
# check: https://opencode.ai or install docs

# Bun
curl -fsSL https://bun.sh/install | bash
```

## Manual Install (links)

- **Flutter**: https://docs.flutter.dev/get-started/install/macos
- **Herd**: https://herd.laravel.com

## Laravel Setup

Local development stack for Laravel projects:

```
Herd ─── PHP 8.4 / 8.5
     ├── Composer
     ├── Laravel installer
     ├── NVM (Node.js v22)
     ├── Nginx (auto-configured)
     └── phpMyAdmin → http://phpmyadmin.test

DBngin ─── MySQL server (local instances)
            └── socket at /tmp/mysql_<PORT>.sock

mysql-client (brew) ─── CLI access to DBngin
```

### Setup steps

1. **Install [Herd](https://herd.laravel.com)** - manages PHP, Composer, Laravel installer, NVM, and Nginx
2. **Install [DBngin](https://dbngin.com)** - GUI for running local MySQL server instances
3. **Install mysql-client** - CLI-only, no server (the server is DBngin)
   ```bash
   brew install mysql-client
   ```
4. **Add to `.zshrc`** (already in dotfiles):
   ```bash
   export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

   # Connect to DBngin MySQL by port (e.g. mysqls 3306)
   function mysqls() {
       command mysql --socket /tmp/mysql_$1.sock -u root
   }
   ```
5. **phpMyAdmin** - add as a Herd site, accessible at `http://phpmyadmin.test`
6. **TablePlus** - GUI database client (optional, alternative to phpMyAdmin)

### Connecting to MySQL

```bash
# Via shortcut function
mysqls 3306

# Via full command
mysql -u root -S /tmp/mysql_3306.sock

# Connect to specific database
mysql -u root -S /tmp/mysql_3306.sock mydb
```

> **Note:** Do NOT install the full `mysql` formula (server+client), it conflicts with DBngin which already runs the server. Only the client is needed.

## Applications

### Development
- Android Studio
- Antigravity
- Antigravity IDE
- Claude
- Codex
- DBngin
- Dia
- Figma
- Gemini
- Ghostty
- Herd
- LM Studio
- Postman
- RStudio
- SF Symbols
- TablePlus
- Visual Studio Code
- Xcode
- Zed

### Creative
- Adobe After Effects 2026
- Adobe Media Encoder 2026
- Adobe Premiere Pro 2026
- BorisFX
- HandBrake
- Maxon
- Red Giant
- REVisionEffects
- Screen Studio
- ZXP Installer

### Communication
- ChatGPT
- Discord
- Telegram
- WhatsApp
- Microsoft Teams
- zoom.us

### Productivity
- Google Chrome
- Keynote
- Numbers
- Pages
- Microsoft Excel
- Microsoft OneNote
- Microsoft Outlook
- Microsoft PowerPoint
- Microsoft Word
- MarkEdit
- SlashTable

### Utilities
- AppCleaner
- BuhoLaunchpad
- CleanMyKeyboard
- CleanShot X
- Cloudflare WARP
- coconutBattery
- DisplayBuddy
- Ghost Buster Pro
- Keka
- KnockKnock
- LaunchOS
- logioptionsplus
- LuLu
- MetalHUDmenu
- Music Presence
- NetSpot
- Quick Camera
- Raycast
- Rectangle
- Speedtest
- Stats
- Tiny Wi-Fi Analyzer
- WhatsYourSign

### Network / Virtualization
- Cisco Packet Tracer 9.0.0
- Parallels Desktop
- VMware Fusion
- WinBox
- Wireshark

### Gaming
- Prism Launcher
- Roblox

### Other
- Keeby
- R
- SongShift
- Spotify

### Installed via Brew Cask (already tracked)
- font-fira-code-nerd-font
- font-jetbrains-mono-nerd-font
- keycastr
- markedit
- ngrok
- rectangle
