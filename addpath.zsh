[[ ! $1 ]] && echo "Please specify a path to add"

# Create paths file if it doesn't exist
[[ -f ~/.paths ]] || echo "#!/bin/zsh\n" > ~/.paths

echo 'export PATH="$PATH:'$1'"' >> ~/.paths