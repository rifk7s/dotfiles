# in order to make fzf and zoxide works together, this must be on the top
autoload -Uz compinit
compinit

#starship.rs - config
eval "$(starship init zsh)"

# zoxide & fzf: z & zi -> cd & cdi
# eval "$(zoxide init zsh)"
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

export TERM=xterm-256color

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"

# Ruby gems
export PATH="$HOME/.gem/ruby/2.6.0/bin:$HOME/.local/share/gem/ruby/2.6.0/bin:$PATH"

# Composer (using Herd's Composer)
#export PATH="$PATH:$HOME/.composer/vendor/bin"

# Node.js - using Herd's nvm (v22.22.0)
# export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# OpenJDK 21
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Flutter (in .zprofile)
# export PATH="$PATH:/Users/rifky/develop/flutter/bin"
# export PATH="$PATH:$HOME/.pub-cache/bin"

# Spicetify (commented out - not installed)
#export PATH=$PATH:/Users/rifky/.spicetify

# uv - local bin (python)
export PATH="$HOME/.local/bin:$PATH"

#thefuck - Helpers
eval $(thefuck --alias)

# bat - cat with highlight
# alias cat="bat"

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

#lstr - list tree?
alias lstr="lstr --icons"

# eza - ls with icons and others
alias ls="eza --icons=auto --group-directories-first --no-symlinks -x"

# fzf alias - fuzzy finder with bat preview
alias fz='fzf --preview "bat --style=header --color=always --line-range :50 {}" --preview-window=right:60% | xargs open'

#yazi - file manager
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Herd - Laravel Setup (PHP, Composer, NVM)


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/rifky/Library/Application Support/Herd/config/php/84/"

# Herd injected NVM configuration
export NVM_DIR="/Users/rifky/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP binary.
export PATH="/Users/rifky/Library/Application Support/Herd/bin/":$PATH

# GitLogs Shortcut
alias gitlog1='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias gitlog2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)"'

export EDITOR=nano
export VISUAL=nano

# git default editor to nano instead of vim
# git config --global core.editor "nano"

# Added by Antigravity
export PATH="/Users/rifky/.antigravity/antigravity/bin:$PATH"

# opencode
export PATH=/Users/rifky/.opencode/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/rifky/.lmstudio/bin"
# End of LM Studio CLI section


# bun completions
[ -s "/Users/rifky/.bun/_bun" ] && source "/Users/rifky/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/rifky/Library/Application Support/Herd/config/php/85/"

# ─── MySQL Client (CLI only, no server) ───────────────────────────────
# Installed via: brew install mysql-client (v9.6.0, keg-only)
#
# Database Server: DBngin (GUI app) — manages MySQL server instances locally.
#   - DBngin stores binaries at: /Users/Shared/DBngin/mysql/<version>/bin/
#   - DBngin creates socket files at: /tmp/mysql_<PORT>.sock (e.g. /tmp/mysql_3306.sock)
#   - Default user: root (no password)
#
# Database Admin UI: phpMyAdmin via Laravel Herd → http://phpmyadmin.test
#
# How to connect via CLI:
#   mysql -u root -S /tmp/mysql_3306.sock          # connect to DBngin on port 3306
#   mysql -u root -S /tmp/mysql_3306.sock <dbname>  # connect directly to a specific database
#
# To find the active socket:
#   ps -ax | grep mysql | grep -v grep             # look for --socket arg in output
#
# NOTE: Do NOT install the full `mysql` formula (server+client) — it conflicts
#       with DBngin which already runs the MySQL server. Only the client is needed.
# ──────────────────────────────────────────────────────────────────────
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Shortcut: connect to DBngin MySQL by port number (e.g. `mysqls 3306`)
function mysqls() {
    command mysql --socket /tmp/mysql_$1.sock -u root
}

# Added by Antigravity IDE
export PATH="/Users/rifky/.antigravity-ide/antigravity-ide/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/rifky/.local/bin:$PATH"
