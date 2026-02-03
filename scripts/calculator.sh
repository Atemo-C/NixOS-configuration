#!/run/current-system/sw/bin/dash

# Check for any command-line arguments, and ignore them if any is detected.
[ "$#" -gt 0 ] && {
	printf "This script does not support command-line arguments. Ignoring.\n"
	nohup "$0" >/dev/null 2>&1 & exit
}

# Check if `bc` is available.
command -v bc >/dev/null 2>&1 || {
	printf "bc could not be found; It is necessary for calculations. Exiting…\n"
	exit 1
}

# Calculator instrultions.
calcinst() {
	# Text formatting outputs for the calculator.
	ARG=$(tput bold; tput setaf 2)
	CMD=$(tput bold; tput setaf 3)
	CLR=$(tput sgr0)
	ICO=$(tput bold; tput setaf 6)

	# Clear the buffer.
	clear

	# Show the instructions.
	printf "%s Calculator%s │ Enter a simple expression to calculate.\n" "$ICO" "$CLR"
	printf "• Type '%sq%s', '%sx%s', or '%sexit%s' to exit.\n" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR"
	printf "• Type '%sclear%s' to clear the screen.\n" "$ARG" "$CLR"
	printf "• Type '%sc%s' or '%sclean%s' to clear the last result.%s\n\n" "$ARG" "$CLR" "$ARG" "$CLR" "$ICO"
}

# Show the instructions upon initial appearance.
calcinst

# Create the `last_result` variable and set it to 0.
last_result=0

# Calculation loop.
while :; do
	# Listen for user input in the variable `i`.
	read -r i

	# Action do execute upon typing something.
	case "$i" in
		# Exit.
		"q"|"x"|"exit") exit 0;;

		# Clear the screen.
		"clear") calcinst && continue;;

		# Clear the last result.
		"c"|"clean")
			printf "%sLast result cleared (0).%s\n" "$CLR" "$ICO"
			last_result=0
			continue;;
	esac

	# Prevent unnecessary scrolling when pressing `Enter` alone.
	[ -z "$i" ] && { tput cuu1 && tput el && continue; }

	# Calculation process.
	[ -n "$i" ] && {
		# If the input starts with an operator, prepend the last result.
		printf "%s" "$i" | grep -q '^[+-\*\/]' && { i="$last_result$i"; }

		# Use `bc` to evaluate the expression.
		result=$(printf "scale=10\n%s\n" "$i" | bc 2>/dev/null) || { printf "" && continue; }

		# Print the result and update the `last_result` variable.
		printf "%s%s%s\n" "$CMD" "$result" "$ICO"
		last_result="$result"
	}
done