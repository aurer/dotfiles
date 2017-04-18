#!/bin/bash

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Make sure we're up to date
branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||');
git pull origin $branch;
unset branch;

for file in .{ash,bash_profile,bashrc,inputrc,gitignore,vim,vimrc,wgetrc} bin ; do
	# Backup existing files
	if [ -f ~/$file -o -d ~/$file ] && [ ! -L ~/$file ]; then
		mv ~/$file ~/$file.orig;
		echo "Moved ~/$file to ~/$file.orig"
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
if ! grep -Fq "path = ~/.dotfiles/.gitconfig" ~/.gitconfig; then
	echo "\n[include]\n\tpath = .dotfiles/.gitconfig\n" >> ~/.gitconfig
fi

# Check for git user.name
if [[ ! $(git config user.name) ]]; then
	printf "Git user.name: ";
	read username;
fi

# Check for git user.email
if [[ ! $(git config user.email) ]]; then
	printf "Git user.email: ";
	read email;
fi

# Write custom git config
printf "[user]\n  name = $username\n  email = $email\n" >> ~/.gitconfig;

source ~/.bash_profile;
