#!/run/current-system/sw/bin/dash
# Orginal script: https://codeberg.org/lukeflo/fuzzel-polkit-agent

# Skip checks and formatting for internal call.
[ "$1" = "_CALLED_INTERNALLY" ] && {
	# Text shortcuts for console log messages.
	CHK="  $(tput setaf 7)Check$(tput sgr0)  │"
	SUC=" $(tput setaf 2; tput bold)Success$(tput sgr0) │"
	WAR=" $(tput setaf 3; tput bold)Warning$(tput sgr0) │"
	ERR="  $(tput setaf 1; tput bold)Error$(tput sgr0)  │"
	RBG="$(tput setab 52)"
	CMD="$(tput setaf 6; tput bold)"
	CLR="$(tput sgr0)"

	# Text functions for console log messages.
	spacer() { printf "─────────┤\n"; }
	ending() { printf "─────────┘\n"; }

	# Text formatting shortcuts for graphical notifications.
	DERR="<b><span foreground='#e60000'>Error</span></b>:"
	DCMD="<b><span foreground='#00d0ff'>"
	DCLR="</span></b>"

	# Print the beginning separator for console log messages.
	printf "─────────┐\n"

	# Check for any command-line arguments.
	printf "%s Checking for command-line arguments…\n" "$CHK"
	[ "$#" -eq 0 ] \
		&& printf "%s Argument check passed.\n" "$SUC" \
		|| printf "%s Command-line arguments are ignored in this script.\n" "$WAR"
	spacer

	# Check if `dunstify` is available.
	printf "%s Checking if %sdunstify%s is available…\n" "$CHK" "$CMD" "$CLR"
	command -v dunstify >/dev/null 2>&1 \
		&& printf "%s %sdunstify%s found; Graphical notifications enabled.\n" "$SUC" "$CMD" "$CLR" \
		&& dunst_dep=true \
		|| printf "%s %sdunstify%s not found; Graphical notifications disabled.\n" "$WAR" "$CMD" "$CLR"
	spacer

	# Function for graphical notifications using `dunstify`.
	errify() { [ "$dunst_dep" = "true" ] && dunstify -u critical "$1" "$2"; }

	# Check if `niri` is the active Wayland compositor.
	printf "%s Checking if %sniri%s is the active desktop…\n" "$CHK" "$CMD" "$CLR"
	if [ "$XDG_CURRENT_DESKTOP" = "niri" ];
	then
		printf "%s %sniri%s is the active desktop.\n" "$SUC" "$CMD" "$CLR"
	else
		printf "%s %s%sniri%s%s is not the active desktop. Exiting…%s\n" \
		"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

		errify "Unsupported environment" \
		"${DERR} ${DCMD}niri${DCLR} is not the active desktop. Exiting…"

		ending
		exit 1
	fi; spacer

	# Check if `fuzzel` is available.
	printf "%s Checking if %sfuzzel%s is available…\n" "$CHK" "$CMD" "$CLR"
	if command -v fuzzel >/dev/null 2>&1;
	then
		printf "%s %sfuzzel%s found; The power menu can be displayed.\n" "$SUC" "$CMD" "$CLR"
	else
		printf "%s %s%sfuzzel%s%s not found; The power menu cannot be displayed. Exiting…%s\n" \
		"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

		errify "Menu program not found" \
		"${DERR} ${DCMD}fuzzel${DCLR} not found; The power menu cannot be displayed. Exiting…"

		ending
		exit 1
	fi; spacer

	# Check if `jq` is available.
	printf "%s Checking if %sjq%s is available…\n" "$CHK" "$CMD" "$CLR"
	if command -v jq >/dev/null 2>&1;
	then
		printf "%s %sjq%s found; Niri's configuration can be parsed.\n" "$SUC" "$CMD" "$CLR"
	else
		printf "%s %s%sjq%s%s not found; Niri's configuration cannot be pasred. Exiting…%s\n" \
		"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

		errify "Menu progarm not found" \
		"${DERR} ${DCMD}jq${DCLR} not found; Niri's configuration cannot be parsed. Exiting…"

		ending
		exit 1
	fi; spacer

	# Check if `cmd-polkit-agent` is available.
	printf "%s Checking if %scmd-polkit-agent%s is available…\n" "$CHK" "$CMD" "$CLR"
	if command -v cmd-polkit-agent >/dev/null 2>&1;
	then
		printf "%s %scmd-polkit-agent%s found; The password prompt can be displayed.\n" "$SUC" "$CMD" "$CLR"
	else
		printf "%s %s%scmd-polkit-agent%s%s not found; The password prompt cannot be displayed. Exiting…%s\n" \
		"$ERR" "$RBG" "$CMD" "$CLR" "$RBG" "$CLR"

		errify "Polkit agent not found" \
		"${DERR} ${DCMD}cmd-polkit-agent${DCLR} not found; The password prompt cannot be displayed. Exiting…"

		ending
		exit 1
	fi; spacer

	# Shift past `_CALLED_INTERNALLY`.
	shift 1

	# Process incoming messages.
	while read -r msg; do
		# Check if the message is a password request.
		printf "%s\n" "$msg" | jq -e '.action == "request password"' >/dev/null 2>&1 || continue

		# Extract prompt and message; Provide defaults if missing.
		prompt=$(printf "%s\n" "$msg" | jq -rc '.prompt // "Password:"')

		# Request password with Fuzzel.
		response=$(fuzzel --dmenu --prompt-color=#ff0000ff --prompt-only="$prompt" --password "$@")

		# Respond based on whether a password was provided.
		[ -z "$response" ] && { printf '{"action":"cancel"}\n' && continue; }

		printf '{"action":"authenticate","password":"%s"}\n' "$response"
	done

	exit 0
}

# Format parameters for passing to internal call.
params=""
for arg in "$@"; do
	params="$params '$arg'"
done

# Start cmd-polkit-agent with internal call.
eval "exec cmd-polkit-agent -s -c '$0 _CALLED_INTERNALLY $params *'"