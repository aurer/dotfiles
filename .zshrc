# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set flags
ZSH_THEME="aurer"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="false"

# Load plugins
plugins=(git git-prompt zsh-autosuggestions)

# Custom aliases
alias gs="git status -sb"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:~/.npm-global/bin
