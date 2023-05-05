#!/bin/zsh

# Enable colors
autoload -U colors && colors

# Hstory
HISTSIZE=1000
SAVEHIST=1000
if [ ! -d ~/.cache/zsh ]; then 
	mkdir -p ~/.cache/zsh/
fi
HISTFILE=~/.cache/zsh/history
SHELL_SESSIONS_DISABLE=1
unsetopt share_history

# Autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Plugins
for package in zsh-autosuggestions zsh-syntax-highlighting; do
	for dir in /usr/share /usr/local/share; do
		if [ -f "$dir/$package/$package.zsh" ]; then
			source "$dir/$package/$package.zsh";
		fi
	done
done

# Config
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases
[ -f ~/.config/zsh/functions ] && source ~/.config/zsh/functions
[ -f ~/.config/zsh/git-prompt ] && source ~/.config/zsh/git-prompt

# Prompt
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
setopt PROMPT_SUBST
PROMPT='%(!:%F{red}%n:%F{cyan}%n)'
PROMPT+='%F{8}@%F{blue}%m'
PROMPT+='%F{8}:%F{magenta}%3~'
PROMPT+='$(git_prompt)'
PROMPT+='
%(?..%F{red}!)%(!:%F{red}❯:%F{cyan}❯)%f '

# Include profile if available
[ -f ~/.profile ] && source ~/.profile
