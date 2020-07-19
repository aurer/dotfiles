#!/bin/zsh

blue=$FG[038];
cyan=$FG[079];
green=$FG[041];
yellow=$FG[172];
orange=$FG[202];
red=$FG[160];
grey=$FG[245];

# Return git status in prompt form
function _git_status() {
	# Unstaged counts
	local M2=0;
	local A2=0;
	local D2=0;
	local R2=0;
	local C2=0;
	local U2=0;
	local I2=0;

	# Staged counts
	local M1=0;
	local A1=0;
	local D1=0;
	local R1=0;
	local C1=0;
	local U1=0;

	# # Don't split on whitespace characters
	ORIGINAL_IFS="${IFS}";
	IFS=$'\n';

	# Loop git status
	for line in $(git status -s --porcelain 2>/dev/null); do
	# Count staged items
	case ${line:0:1} in
		'M') ((M1+=1));;
		'D') ((D1+=1));;
		'A') ((A1+=1));;
		'R') ((R1+=1));;
		'C') ((C1+=1));;
		'U') ((U1+=1));;
	esac;

		# Count unstaged items
		case ${line:1:1} in
			'M') ((M2+=1));;
			'D') ((D2+=1));;
			'A') ((A2+=1));;
			'R') ((R2+=1));;
			'C') ((C2+=1));;
			'?') ((U2+=1));;
			'!') ((I2+=1));;
		esac;
	done;

	# Reset split on whitespace
	IFS="${ORIGINAL_IFS}"

	# Output
	local unstaged='';
	local staged='';
	local result='';

	for state in {M2,A2,D2,R2,C2,U2,I2,M1,A1,D1,R1,C1}; do
		if [[ "$(($state))" != "0" ]]; then
			case "$state" in
				# Staged
				M1) staged+="${green}•$(($state))";;
				A1) staged+="${green}+$(($state))";;
				D1) staged+="${red}-$(($state))";;
				R1) staged+="${blue}~$(($state))";;
				C1) staged+="${blue}C$(($state))";;
				U1) staged+="${blue}C$(($state))";;

				# Unstaged items
				M2) unstaged+="${yellow}•$(($state))";;
				A2) unstaged+="${yellow}+$(($state))";;
				D2) unstaged+="${red}-$(($state))";;
				R2) unstaged+="${blue}~$(($state))";;
				C2) unstaged+="${blue}C$(($state))";;
				U2) unstaged+="${blue}?$(($state))";;
				I2) unstaged+="${blue}?$(($state))";;
			esac;
		fi
	done

	# Trim whitespace
	unstaged=$(echo $unstaged | sed -e "s/^ *//");
	staged=$(echo $staged | sed -e "s/^ *//");

	# Compile result
	result='';
	if [[ -n "$staged" ]]	result+="$staged";
	if [[ -n $staged && -n $unstaged ]] result+="$grey|";
	if [[ -n "$unstaged" ]] result+="$unstaged";

	# Return output
	echo $result;
}

# Return branch being ahead or behind the remote
function git_pos() {
	local branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||');
	local ahead=$(git rev-list --left-right $branch...origin/$branch 2>/dev/null | grep -c '^<' | tr -d ' ');
	local behind=$(git rev-list --left-right $branch...origin/$branch 2>/dev/null | grep -c '^>' | tr -d ' ');
	local pos="";
	if [[ "$ahead" -gt 0 ]]; then pos+="↑$ahead"; fi
	if [[ "$behind" -gt 0 ]]; then pos+="↓$behind"; fi
	if [[ "$pos" != "" ]]; then echo "$blue$pos"; fi
}

# Compile git prompt using branch, status and position
function git_prompt() {
	# check if we're in a git repo
	git rev-parse &>/dev/null || return;

	# check if we're not in a .git folder in the repo
	[[ $(git rev-parse --is-inside-work-tree) == 'false' ]] && return;

	# Get curent branch
	local statusColor=$green;
	local branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

	# If branch is empty find hash
	if [[ -z "$branch" ]]; then
		warning="$red DETACHED HEAD"
		statusColor=$orange;
		branch="$grey#"$(git rev-parse --short HEAD);

		local tag=$(git describe --tags 2>/dev/null)
		if [[ -n "$tag" ]]; then
		branch="$grey@$tag"
		fi
	fi

	# Check for stashes
	local stashes=$(git stash list | wc -l | tr -d ' ')
	if [[ "$stashes" != "0" ]]; then
		stashes="$orange ⚑$stashes";
	else
		stashes=""
	fi

	# # Color based on number of changes
	local state=$(_git_status);
	# local color;
	if [[ -n "$state" ]]; then
		statusColor=$orange;
		state=" $state"
	fi

	result="$statusColor$branch$(git_pos)$state$stashes"

	echo "$statusColor($result$statusColor)$warning ";
}