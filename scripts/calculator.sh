#!/usr/bin/env dash

# Credits.
# • DASH:   http://gondor.apana.org.au/~herbert/dash
# • GNU bc: https://www.gnu.org/software/bc

# Text formatting shortcuts for console messages using `printf`.
arg=$(tput bold; tput setaf 2)
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Check for any argument that may be present.
[ "$#" -ne 0 ] && { printf "%s: This script does not support command-line arguments. Ignoring.\n" "$war"; }

# Check if bc is installed.
command -v bc > /dev/null 2>&1 || {
	printf "%s: %sbc%s could not be found. It is necessary for calculations. Exiting.\n" "$err" "$exe" "$clr"

	exit 1
}

# Calculator instructions.
calcinst() {
	clear
	printf "%s Calculator%s │ Enter a simple expression to calculate.\n" "$ico" "$clr"
	printf "• Type '%sq%s', '%sx%s', or '%sexit%s' to exit.\n" "$arg" "$clr" "$arg" "$clr" "$arg" "$clr"
	printf "• Type '%sclear%s' to clear the screen.\n" "$arg" "$clr"
	printf "• Type '%sc%s' or '%sclean%s' to clear the last result.%s\n\n" "$arg" "$clr" "$arg" "$clr" "$ico"
}

# Show the instructions on the initial appearance.
calcinst

# Create the last_result variable and set it to 0.
last_result=0

# Calculation loop.
while true; do
	# Listen for user input in the variable `i`.
	read -r i

	# Exit if `q`, `x`, or `exit` are typed.
	[ "$i" = "q" ] || [ "$i" = "x" ] || [ "$i" = "exit" ] && { exit; }

	# Clear the screen if `c` or `clear` are typed.
	[ "$i" = "clear" ] && { calcinst && continue; }

	# Clear the last result if `ESCAPE` is pressed.
	[ "$i" = "c" ] || [ "$i" = "clean" ] && { last_result=0 && continue; }

	# Prevent unnecessary scrolling when pressing `Enter` alone.
	[ -z "$i" ] && { tput cuu1 && tput el && continue; }

	# Calculation process.
	[ -n "$i" ] && {
		# If the input starts with an operator, prepend the last result.
		printf "%s" "$i" | grep -q '^[+-\*\/]' && { i="$last_result$i"; }

		# Use `bc` to evaluate the expression.
		result=$(printf "%s\n" "$i" | bc 2>/dev/null) || { printf "" && continue; }

		# Print the result and update the `last_result` variable.
		printf "%s%s%s\n" "$exe" "$result" "$ico"
		last_result="$result"
	}
done