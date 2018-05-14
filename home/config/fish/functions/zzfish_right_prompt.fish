set caller %self
set pipe /tmp/fish_prompt_{$caller}

# Make sure our pipe exists:
if not test -e $pipe
	touch $pipe
	chmod 600 $pipe
end

# Wait for a new fish prompt (but not a refreshed prompt)
function update_fish_right_prompt --on-event fish_prompt
	if not set -q _fish_prompt_update_{$caller}_running
		set -U _fish_prompt_update_{$caller}_running

		# Clear the previous prompt:
		printf "\n" > $pipe

		# Start the async process:
                ~/.config/fish/functions/fish_right_prompt_async.fish $caller &
	end
end

function fish_right_prompt
        # Make sure we initialise the prompt the first time:
	if not set -q _fish_prompt_update_{$caller}_init
		set -g _fish_prompt_update_{$caller}_init
		update_fish_right_prompt
	end

	# Get the prompt update:
	if tail -1 $pipe | read -l line
		set update $line
	end

	echo $update
end
