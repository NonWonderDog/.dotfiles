#!/usr/bin/env fish
set caller $argv[1]
set pipe /tmp/fish_prompt_{$caller}

function append --description 'Append text to the end of the prompt.'
	echo -n "$argv" >> $pipe
	kill -WINCH $caller
end

# Use git prompt
append (__fish_git_prompt)
append (__fish_svn_prompt)
append ' '

# Allow another update script to run:
set -e _fish_prompt_update_{$caller}_running
