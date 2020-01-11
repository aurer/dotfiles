#!/bin/zsh

# resolve symlinks when changing directory
setopt chase_links

# ignore case when globbing
setopt no_case_glob 

# enable auto cd
setopt auto_cd

# share history across multiple zsh sessions
setopt share_history

# append to history
setopt append_history

# adds commands as they are typed, not at shell exit
setopt inc_append_history

# expire duplicates first
setopt hist_expire_dups_first 

# do not store duplications
setopt hist_ignore_dups

#ignore duplicates when searching
setopt hist_find_no_dups

# removes blank lines from history
setopt hist_reduce_blanks

# enable substring on prompt so git_status runs every time
setopt prompt_subst