if [[ -n $SSH_CONNECTION ]]; then
	PROMPT='%(!:%{$fg_bold[red]%}%n:%{$cyan%}%n)%{$blue%}@%m%{$reset_color%}';
else
	PROMPT='%(!:%{$fg_bold[red]%}%n:)%{$reset_color%}'
fi
PROMPT+=' %{$cyan%}%3~%{$reset_color%} $(git_prompt)'
PROMPT+="%(!:%{$fg[red]%}❯:%{$fg[cyan]%}❯) %{$reset_color%}"