#!/bin/bash

#########################################################################
# This file is managed centrally, any manual changes might be overwritten
#########################################################################

export TERM=xterm-256color
[ -n "$PS1" ] && source ~/.bash_profile

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source yarn global modules
if [[ -d $HOME/.yarn ]]; then
 export PATH="$HOME/.yarn/bin:$PATH"
fi
