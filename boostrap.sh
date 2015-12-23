#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
fi

if [ -d /etc/profile.d ]; then
  for script in bash_aliases.sh bash_profile.sh bash_prompt.sh
  do
    ln -sf $DIR/$script /etc/profile.d/$script
  done
fi
