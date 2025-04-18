#!/bin/dash

# Set some text formatting shortcuts.
arg=$(tput bold)$(tput setaf 2)
ico=$(tput bold)$(tput setaf 6)
exe=$(tput bold)$(tput setaf 3)
num=$(tput bold)$(tput setaf 6)
dim=$(tput dim)
c=$(tput sgr0)

# Echo instructions to the user.
echo \
	"${ico} Calculator${c} ${dim}(proof of concept, very dumb, use bc instead.)${c}\n" \
	"\n• Enter a simple expression to calculate." \
	"\n• Type '${arg}q${c}', '${arg}x${c}', or '${arg}exit${c}' to exit." \
	"\n• Type '${arg}c${c}' or '${arg}clear${c}' to clear the screen.${num}\n"

# Create the last_result variable.
last_result=0

# Create the calculation loop.
while true; do
	# Listen for user input in the variable "i".
	read -r i

	# Exit if q or exit pressed.
	[ "$i" = "q" ] || [ "$i" = "x" ] || [ "$i" = "exit" ] && {
		exit
	}

	# Clear the last result if c or clear is pressed.
	[ "$i" = "c" ] || [ "$i" = "clear" ] && {
		clear
		echo \
			"${ico} Calculator${c} ${dim}(proof of concept, very dumb, use bc instead.)${c}\n" \
			"\n• Enter a simple expression to calculate." \
			"\n• Type '${arg}q${c}', '${arg}x${c}', or '${arg}exit${c}' to exit." \
			"\n• Type '${arg}c${c}' or '${arg}clear${c}' to clear the screen.${num}\n"
		continue
	}

	# If the user presses Enter without anything, prevent unnecessary scrolling.
	[ -z "$i" ] && {
		tput cuu1
		tput el
		continue
	}

	# Start the calculation process.
	[ -n "$i" ] && {
		# If the input starts with an operator, prepend the last result.
		echo "$i" | grep -q '^[+-\*\/]' && {
			i="$last_result$i"
		}
	}

	# Calculate and output the result.
	[ -n "$i" ] && {
		# If the input starts with an operator, prepend the last result.
		echo "$i" | grep -q '^[+-\*\/]' && {
			i="$last_result$i"
		}

		# Use a subshell to evaluate the expression and handle (ignore) errors.
		result=$(sh -c "echo $(( $i ))" 2>/dev/null) || {
			echo ""
			continue
		}
		echo "${exe}$result${num}\n"
		last_result=$result
	}

# End the calculation loop.
done
