#!/bin/bash

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Make sure we're up to date
git pull;

for file in .{ash,bash_profile,bashrc,inputrc,gitconfig,gitignore,vim,vimrc,wgetrc} bin ; do
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
cat > ~/.gitconfig.local <<EOL
[user]
	name = $username
	email = $email
EOL

source ~/.bash_profile;
