#!/bin/bash

#########################################################################
# This file is managed centrally, any manual changes might be overwritten
#########################################################################

# Add `~/bin` and composer bin to the `$PATH`
export PATH="$PATH:$HOME/bin:/usr/local/bin:~/.composer/vendor/bin"

# Load the shell dotfiles
for file in ~/.ash/.{colors,git_prompt,bash_prompt,bash_aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load overide shell dotfiles
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,extra,ash/z}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell
