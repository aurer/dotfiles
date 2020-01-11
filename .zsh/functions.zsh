#!/bin/zsh

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$@"
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* *
	fi
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}"
	sleep 1 && open "http://localhost:${port}/" &&  php -S "localhost:${port}";
}

# Run git status -s on any git repository within the current directory
function git_subrepo_status() {
	CURRENT_DIR=$(pwd);
	REPOS=($(find ./ -name .git | cut -c3-))
	REPO_COUNT=${#REPOS[@]}
	if [ $REPO_COUNT = 0 ]; then
		echo "${red}No repositories were found${reset}"
	else
		echo "${green}$REPO_COUNT repos found...${reset}"
		for repo in ${REPOS[@]}; do
			cd ".$repo/..";
			echo;
			pwd && git_prompt;
			cd $CURRENT_DIR;
		done
	fi
}

# Move a file to the trash
function d() {
	mv $1 ~/.Trashes/
}

# Add to PATH
function addpath() {
	[[ ! $1 ]] && echo "Please specify a path to add"

	# Create paths file if it doesn't exist
	[[ -f ~/.paths ]] || echo "#!/bin/zsh\n" > ~/.paths

	# Add path
	echo 'export PATH="$PATH:'$1'"' >> ~/.paths
}