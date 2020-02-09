#!/bin/zsh

printf "\nInstalling\n----------\n\n"

if [[ ! -a /bin/zsh ]]; then
	echo "Required binary '/bin/zsh' is not installed";
	return 1;
fi

echo "Switch to zsh"
chsh -s /bin/zsh

# Set the base directory
dir=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Install files
for file in .{zshrc,inputrc,gitignore,vim,vimrc,wgetrc}; do
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

# Add include for gitconfig
touch ~/.gitconfig
if ! grep -Fq "$dir/.zsh" ~/.gitconfig; then
	printf "\n\n[include]\n  path = $dir/.zsh/.gitconfig\n\n" >> ~/.gitconfig
fi

# Check for git user.name
if [[ ! $(git config user.name) ]]; then
	read -p "Git user.name: " username;
	git config --global user.name "$username";
fi

# Check for git user.email
if [[ ! $(git config user.email) ]]; then
	read -p "Git user.email: " email;
	git config --global user.email "$email";
fi

printf "\n----\nDone, type 'reload' to reload configuration\n"
unset dir
