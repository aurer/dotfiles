#!/usr/bin/env ruby

# check if we're in a git repo
if `git rev-parse --is-inside-work-tree &>/dev/null || exit 1`
	puts "This folder is already managed by git"
	# exit
end

remote = ARGV[0]
if !remote
	print "Repository url: "
	remote = STDIN.gets.chomp
end

branch = ARGV[1]
if !branch
	branch = 'develop'
end

system "git init"
system "git remote add origin #{remote}"
system "git fetch"
system "git checkout -f #{branch}"
