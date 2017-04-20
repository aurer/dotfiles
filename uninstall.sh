#!/bin/bash

printf "\nUninstalling\n------------\n\n"

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Install files
for file in .{dotfiles,bash_profile,bashrc,inputrc,gitignore,vim,vimrc,wgetrc}; do
	# Remove existing symlinks
	if [ -L ~/$file ]; then
		rm -rf ~/$file;
	fi;

	# Restore originals
	if [ -f ~/$file.orig -o -d ~/$file.orig ] && [ ! -L ~/$file.orig ]; then
		mv ~/$file.orig ~/$file;
		echo "Moved ~/$file.orig to ~/$file"
	fi;
done;
unset file
unset dir

# Remove include frpm gitconfig
if ! grep -Fq "path = ~/.dotfiles/.gitconfig" ~/.gitconfig; then
	sed -i -e '/  path = \.dotfiles\/\.gitconfig/g' ~/.gitconfig
fi

printf "\n----\nDone\n"
