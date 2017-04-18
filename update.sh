#!/bin/bash

printf "\n--------\Updating\n--------\n\n"

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Make sure we're up to date
branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||');
git pull origin $branch;
unset branch;

for file in .{dotfiles,bash_profile,bashrc,inputrc,gitignore,vim,vimrc,wgetrc} bin ; do
	# Backup existing files
	if [ -f ~/$file -o -d ~/$file ] && [ ! -L ~/$file ]; then
		mv ~/$file ~/$file.orig;
		printf "Moved ~/$file to ~/$file.orig"
	fi;

	# Remove existing symlinks
	if [ -L ~/$file ]; then
		rm -rf ~/$file;
	fi;

	# Create the symlink
	ln -sf $dir/$file ~/$file;
done;

unset file
unset dir

source ~/.bash_profile;

printf "\n----\nDone\n----\n"
