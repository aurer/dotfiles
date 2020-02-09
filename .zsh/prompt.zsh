#!/bin/zsh

# Set PS2
PS2='$usercolor❯ $reset'

# Set PS1
if [[ "$EUID" == 0 ]]; then 
  userprompt='';
  usercolor=$red; 
else 
  usercolor=$cyan; 
fi

function location_prompt() {
  local USER_P=""
  local IS_SSH=false
  local LOCATION_p=""
  
  if [[ "$EUID" == 0 ]]; then 
    USER_P="$usercolor%m "
  fi 
  
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    IS_SSH=true
  else
    case $(ps -o comm= -p $PPID) in
      sshd|*/sshd) IS_SSH=true;
    esac
  fi

  if [ "$IS_SSH" ]; then
    local LOCATION_P="$cyan%n "
  fi

  echo "$USER_P$LOCATION_p"
}

PS1='$(location_prompt)$blue%~ $(git_prompt)$usercolor
❯ $reset'