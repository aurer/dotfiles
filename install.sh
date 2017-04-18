#!/bin/bash

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Install files
for file in .{dotfiles,bash_profile,bashrc,inputrc,gitignore,vim,vimrc,wgetrc}; do
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

# Add include for gitconfig
touch ~/.gitconfig
if ! grep -Fq "path = ~/.dotfiles/.gitconfig" ~/.gitconfig; then
	printf "\n[include]\n  path = .dotfiles/.gitconfig\n" >> ~/.gitconfig
fi

# Check for git user.name
if [[ ! $(git config user.name) ]]; then
	echo "Git user.name: ";
	read username;
fi

# Check for git user.email
if [[ ! $(git config user.email) ]]; then
	echo "Git user.email: ";
	read email;
fi

# Write custom git config
printf "\n[user]\n\tname = $username\n\temail = $email\n" >> ~/.gitconfig;

source ~/.bash_profile;
