#!/bin/zsh

printf "\nInstalling\n----------\n\n"

if [[ ! -a /bin/zsh ]]; then
	echo "Required binary '/bin/zsh' is not installed";
	return 1;
fi

if [[ "$SHELL" != "/bin/zsh" ]]; then
	echo "Switch to zsh";
	chsh -s /bin/zsh;
fi

# Set the base directory
DOTFILES=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd );

# Check for git user.name
if [[ ! $(git config user.name) ]]; then
	read "?Git user.name: " username;
	git config --global user.name "$username";
fi

# Check for git user.email
if [[ ! $(git config user.email) ]]; then
	read "?Git user.email: " email;
	git config --global user.email "$email";
fi

# Install useful files
for file in .{gitignore,vim,vimrc,wgetrc}; do
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
	ln -sf $DOTFILES/$file ~/$file;
done;
unset file

install_with_oh_my_zsh () {
	# Install oh-my-zsh
	if [[ ! -d ~/.oh-my-zsh ]]; then
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
	fi

	# Install autosuggestions plugin
	if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
	fi
	
	# Add custom .zshrc, theme and plugin
	cp -i $DOTFILES/.zshrc.oh-my-zsh ~/.zshrc;
	cp -i $DOTFILES/.oh-my-zsh/custom/*.zsh ~/.oh-my-zsh/custom/;
	cp -ir $DOTFILES/.oh-my-zsh/custom/plugins/git-prompt ~/.oh-my-zsh/custom/plugins/;
	cp -i $DOTFILES/.oh-my-zsh/custom/themes/aurer.zsh-theme ~/.oh-my-zsh/custom/themes/;
	source ~/.zshrc;
}

install_without_oh_my_zsh () {
	# Install files
	for file in .{zshrc}; do
		# Backup existing files
		if [ -f ~/$file -o -d ~/$file ] && [ ! -L ~/$file ]; then
			mv ~/$file ~/$file.orig;
			echo "Moved ~/$file to ~/$file.orig"
		fi;

		# Create the symlink
		cp -i $DOTFILES/$file ~/$file;
	done;
	unset file
}

# Select install type
while true; do
    echo -n "Use oh-my-zsh? (y/n) "
		read yn
    case $yn in
        [Yy]* ) install_with_oh_my_zsh; break;;
        [Nn]* ) install_without_oh_my_zsh; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

unset DOTFILES
printf "\n----\nDone, open a new tab to see changes\n"
