#!/bin/bash

# Execute as root
#(( EUID != 0 )) && exec sudo -- "$0" "$@"

# Set the base directory
DIR=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )

for file in .{ash,bash_profile,bashrc,gitconfig,vimrc,wgetrc,vim} ; do
	if [ -f ~/$file ]; then
		printf "Overwrite '${file}'? (Y/n)";
		read ANSWER;
		if [[ $ANSWER =~ ^[Nn]$ ]]; then
			continue;
		else
			mv ~/$file ~/$file.orig;
		fi
	fi;
	ln -sf $DIR/$file ~/$file;

done;

unset file
unset DIR
unset ANSWER
