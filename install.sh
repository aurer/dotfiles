#!/bin/bash

# Check for zsh
if [ "$SHELL" != "/bin/zsh" ]; then 
	echo "It looks like your not using zsh, please install this before continuing"
	exit 1
fi

# Set the base directory
BASEDIR=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Create required folders
echo "Create required folders"
mkdir -p ~/.config/zsh
mkdir -p ~/.cache/zsh

# Install zsh configuration
echo "Install zsh configuation"
cp -R $BASEDIR/files/config/zsh/* ~/.config/zsh/
cp $BASEDIR/files/zshrc ~/.zshrc

# Install micro configuration
echo "Install micro configuration"
mkdir -p ~/.config/micro
cp $BASEDIR/files/config/micro/* ~/.config/micro/

# Setup vim
echo "Setup vim"
mkdir -p ~/.vim
cp -r $BASEDIR/files/vim/* ~/.vim/

# Check for git user.name
echo "Configure git"

# Copy configs
mkdir -p ~/.config/git
cp -r $BASEDIR/files/config/git/* ~/.config/git/

# Include config
if [ ! -f ~/.gitconfig ]; then 
	printf "[include]\n  path = ~/.config/git/config\n\n" > ~/.gitconfig
fi

# Set user.name
if [[ ! $(git config user.name) ]]; then
	read -p "Git user.name: " name;
	git config --global user.name "$name";
fi

# Set user.email
if [[ ! $(git config user.email) ]]; then
	read -p "Git user.email: " email;
	git config --global user.email "$email";
fi

echo "Done"
unset BASEDIR