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

# Add include for gitconfig
touch ~/.gitconfig
if ! grep -Fq "$DOTFILES/.zsh" ~/.gitconfig; then
	printf "\n\n[include]\n  path = $DOTFILES/.zsh/.gitconfig\n\n" >> ~/.gitconfig
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

install_with_oh_my_zsh () {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
	cp -i $DOTFILES/.zshrc.oh-my-zsh ~/.zshrc;
	cp -ir $DOTFILES/.oh-my-zsh/custom/plugins/git-prompt ~/.oh-my-zsh/custom/plugins/;
	cp -i $DOTFILES/.oh-my-zsh/custom/themes/aurer.zsh-theme ~/.oh-my-zsh/custom/themes/;
}

install_without_oh_my_zsh () {

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
		ln -sf $DOTFILES/$file ~/$file;
	done;
	unset file
}

# Select install type
while true; do
    echo -n "Install oh-my-zsh? (y/n) "
		read yn
    case $yn in
        [Yy]* ) install_with_oh_my_zsh; break;;
        [Nn]* ) install_without_oh_my_zsh; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

unset DOTFILES
printf "\n----\nDone, open a new tab to see changes\n"
