#!/bin/bash

# Execute as root
#(( EUID != 0 )) && exec sudo -- "$0" "$@"

# Set the base directory
DIR=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )

for file in .{ash,bash_profile,bashrc,gitconfig,vim,vimrc,wgetrc} ; do
	if [ -f ~/$file -o -d ~/$file ] && [ ! -L ~/$file ]; then
		mv ~/$file ~/$file.orig;
		echo "Moved ~/$file to ~/$file.orig"
	fi;

	ln -sf $DIR/$file ~/$file;
done;

unset file
unset DIR
