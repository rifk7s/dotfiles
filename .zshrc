#setopt CORRECT
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export PATH="$PATH:/Users/rifky/develop/flutter/bin"

export PATH=$PATH:/Users/rifky/.spicetify

#starship.rs - config
eval "$(starship init zsh)"

#thefuck - Helpers
eval $(thefuck --alias)

#bat - cat with highlight
alias cat="bat"

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
