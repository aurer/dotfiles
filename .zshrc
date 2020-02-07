#!/bin/zsh

#########################################################################
# This file is managed centrally, any manual changes might be overwritten
#########################################################################

# Load the shell dotfiles
dir=$(dirname $(readlink ~/.zshrc))
for f in .zsh/{options,aliases,colors,git,functions,prompt}.zsh; do
	[[ -r "$dir/$f" ]] && [[ -f "$dir/$f" ]] && source "$dir/$f"
done
unset f
unset dir

# Load custom paths
[[ -f ~/.paths ]] && source ~/.paths