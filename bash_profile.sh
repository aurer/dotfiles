#!/bin/bash

#########################################################################
# This file is managed centrally, any manual changes might be overwritten
#########################################################################

# Add `~/bin` and composer bin to the `$PATH`
export PATH="$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,git_prompt,bash_aliases,exports,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell
