export TERM=xterm-256color

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"

# Ruby gems
export PATH="$HOME/.gem/ruby/2.6.0/bin:$HOME/.local/share/gem/ruby/2.6.0/bin:$PATH"

# Composer (now using Herd's Composer)
#export PATH="$PATH:$HOME/.composer/vendor/bin" 


# Node.js - now using Herd's nvm (v22.22.0)
# export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# OpenJDK 21
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Flutter (now in .zprofile)
# export PATH="$PATH:/Users/rifky/develop/flutter/bin"
# export PATH="$PATH:$HOME/.pub-cache/bin"

# Spicetify (commented out - not installed yet)
#export PATH=$PATH:/Users/rifky/.spicetify

# uv - local bin
export PATH="$HOME/.local/bin:$PATH"

#starship.rs - config
eval "$(starship init zsh)"

#thefuck - Helpers
eval $(thefuck --alias)

#bat - cat with highlight
# alias cat="bat"

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

#eza - ls with icons and others
alias ls="eza --icons=auto --group-directories-first --no-symlinks -x"

#zoxide & fzf
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

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

#nvm - nodejs version manager

# Laravel Herd App (automatically set after installing Herd)

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/rifky/Library/Application Support/Herd/config/php/84/"


# Herd injected NVM configuration
export NVM_DIR="/Users/rifky/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP binary.
export PATH="/Users/rifky/Library/Application Support/Herd/bin/":$PATH
