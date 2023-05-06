# History size
SHELL_SESSIONS_DISABLE=1
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000

# Extended glob
setopt autocd extendedglob

# Emacs style kiybindings
bindkey -e

# Autocomplete
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit
zmodload zsh/complist
_comp_options+=(globdots)

# Plugins
for package in zsh-autosuggestions zsh-syntax-highlighting; do
	for dir in /usr/share /usr/local/share; do
		if [ -f "$dir/$package/$package.zsh" ]; then
			source "$dir/$package/$package.zsh"
		fi
	done
done

# Config
source ~/.config/zsh/aliases
source ~/.config/zsh/functions

# Include zprofile if available
[ -f ~/.zprofile ] && source ~/.zprofile

# Enable starship
eval "$(starship init zsh)"
