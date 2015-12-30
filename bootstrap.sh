#!/bin/bash

# Execute as root
#(( EUID != 0 )) && exec sudo -- "$0" "$@"

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )

for file in .{ash,bash_profile,bashrc,gitconfig,gitignore,vim,vimrc,wgetrc} ; do
	if [ -f ~/$file -o -d ~/$file ] && [ ! -L ~/$file ]; then
		mv ~/$file ~/$file.orig;
		echo "Moved ~/$file to ~/$file.orig"
	fi;

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

cat > ~/.gitconfig.local <<EOL
[user]
	name = $username
	email = $email
EOL
