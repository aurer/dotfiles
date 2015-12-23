bold=$(tput bold);
reset=$(tput sgr0);
black=$(tput setaf 0);
blue=$(tput setaf 31);
cyan=$(tput setaf 115);
green=$(tput setaf 113);
orange=$(tput setaf 172);
pink=$(tput setaf 161);
red=$(tput setaf 160);
violet=$(tput setaf 103);
yellow=$(tput setaf 214);
white=$(tput setaf 15);
grey=$(tput setaf 239);

function git_status() {
  local modified=0;
  local added=0;
  local deleted=0;
  local renamed=0;
  local copied=0;
  local untracked=0;
  local ignored=0;
  local output=$(git status -s 2>/dev/null)

  OIFS="${IFS}"
  IFS=$'\n'
  for line in ${output}; do
    if [[ $line == M* ]] || [[ $line == " M"* ]]; then
      modified=$((modified+1));
    elif [[ $line == A* ]]; then
      added=$((added+1));
    elif [[ $line == D* ]]; then
      deleted=$((deleted+1));
    elif [[ $line == R* ]]; then
      renamed=$((renamed+1));
    elif [[ $line == C* ]]; then
      copied=$((copied+1));
    elif [[ $line == ?* ]]; then
      untracked=$((untracked+1))
    elif [[ $line == !* ]]; then
      ignored=$((ignored+1));
    fi
  done
  IFS="${OIFS}"

  s=''
  if [ $modified != "0" ]; then
      s+="${yellow}*${modified} ";
  fi
  if [ $added != "0" ]; then
      s+="${yellow}+${added} ";
  fi
  if [ $deleted != "0" ]; then
      s+="${red}-${deleted} ";
  fi
  if [ $renamed != "0" ]; then
      s+="${yellow}*${renamed} ";
  fi
  if [ $copied != "0" ]; then
      s+="${yellow}*${copied} ";
  fi
  if [ $untracked != "0" ]; then
      s+="${green}?${untracked} ";
  fi
  if [ $ignored != "0" ]; then
      s+="${white}\${ignored} ";
  fi

  echo $s
}

git_status
