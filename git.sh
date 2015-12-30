. .ash/.colors;

function _git_status() {
	# Don't split on whitespace characters
	ORIGINAL_IFS="${IFS}"; IFS=$'\n';

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

	# Output
	local UNSTAGED='';
	local STAGED='';

	# Loop git status
	for line in $(git status -s 2>/dev/null); do
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

		# Count staged items
		case ${line:0:1} in
			'M') ((M1+=1));;
			'D') ((D1+=1));;
			'A') ((A1+=1));;
			'R') ((R1+=1));;
			'C') ((C1+=1));;
		esac;
	done;

	for state in {M2,A2,D2,R2,C2,U2,I2,M1,A1,D1,R1,C1}; do
		if [ "${!state}" != "0" ]; then
			case "$state" in
				# Unstaged items
				M2) UNSTAGED+=" ${yellow}*${!state}$reset";;
				A2) UNSTAGED+=" ${green}+${!state}$reset";;
				D2) UNSTAGED+=" ${red}-${!state}$reset";;
				R2) UNSTAGED+=" ${blue}R${!state}$reset";;
				C2) UNSTAGED+=" ${blue}C${!state}$reset";;
				U2) UNSTAGED+=" ${blue}U${!state}$reset";;
				I2) UNSTAGED+=" ${blue}I${!state}$reset";;

				# Staged
				M1) STAGED+=" ${yellow}*${!state}$reset";;
				A1) STAGED+=" ${green}+${!state}$reset";;
				D1) STAGED+=" ${red}-${!state}$reset";;
				R1) STAGED+=" ${blue}R${!state}$reset";;
				C1) STAGED+=" ${blue}C${!state}$reset";;
			esac;
		fi
	done

	# Trim whitespace
	UNSTAGED=$(echo $UNSTAGED | sed -e "s/^ *//");
	STAGED=$(echo $STAGED | sed -e "s/^ *//");

	# Reset split on whitespace
	ORIGINAL_IFS="${OIFS}"

	# Return output
	echo "$UNSTAGED ($STAGED)";
}

_git_status;
