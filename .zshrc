#!/bin/zsh

#########################################################################
# This file is managed centrally, any manual changes might be overwritten
#########################################################################

# Load the shell dotfiles
dir=$(dirname $(readlink ~/.zshrc))
for f in .zsh/{options,aliases,colors,git,functions}.zsh; do
	[[ -r "$dir/$f" ]] && [[ -f "$dir/$f" ]] && source "$dir/$f"
done
unset f
unset dir

[[ -f ~/.paths ]] && source ~/.paths

# Set prompt
if [[ "$EUID" == 0 ]]; then usercolor=$red; else usercolor=$cyan; fi
PS1='$cyan%m$white:$usercolor%n $blue%~ $(git_prompt)$uc➔ $white'