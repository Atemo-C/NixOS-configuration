#!/usr/bin/env dash

# Credits.
# • Original script: https://codeberg.org/lukeflo/fuzzel-polkit-agent
# • cmd-polkit:      https://github.com/OmarCastro/cmd-polkit
# • DASH:            http://gondor.apana.org.au/~herbert/dash
# • Fuzzel:          https://codeberg.org/dnkl/fuzzel
#
# This script is mostly just a slightly reformatted version of the original.
# This allows it to follow my other scritps' styling and behavior.
# All credits goes to @lukeflo for this.

# Skip checks and formatting for internal call.
[ "$1" = "_CALLED_INTERNALLY" ] && {
	# Shift past _CALLED_INTERNALLY.
	shift 1

	# Process incoming messages.
	while read -r msg; do
		# Check if message is a password request.
		printf "%s\n" "$msg" | jq -e '.action == "request password"' > /dev/null 2>&1 || continue

		# Extract prompt and message, provide defaults if missing.
		prompt=$(printf "%s\n" "$msg" | jq -rc '.prompt // "Password:"')

		# Request password with fuzzel.
		response=$(fuzzel --dmenu --prompt-only="$prompt" --password "$@")

		# Respond based on whether a password was provided.
		[ -z "$response" ] && { printf '{"action":"cancel"}\n' && continue; }

		printf '{"action":"authenticate","password":"%s"}\n' "$response"
	done

	exit
}

# Text formatting shortcuts for console messages using `printf`.
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
derr="<b><span foreground='#ff0000'>Error</span></b>"
dexe="<b><span foreground='#ffc000'>"

# Check for any argument that may be present.
[ "$#" -ne 0 ] && { printf "%s: This script does not support command-line arguments. Ignoring.\n" "$war"; }

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s: %sDunst%s could not be found. Graphical notifications disabled. Continuing.\n" "$war" "$exe" "$clr"

	dunst_dep=false
}; [ "$dunst_dep" = false ] || { dunst_dep=true; }

# Function for graphical notifications using dunstify.
notify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s: This script is made to be used within the %sNiri%s Wayland compositor. Exiting.\n" "$err" "$exe" "$clr"

	notify "Niri not detected" \
	"${derr}: This script is made to be used within the ${dexe}Niri${bspan} Wayland compositor. Exiting."

	exit 1
}

# Check if Fuzzel is installed.
command -v fuzzel > /dev/null 2>&1 || {
	printf "%s: %sFuzzel%s could not be found. It is necessary to display the password prompt. Exiting.\n" "$err" "$exe" "$clr"

	notify "Fuzzel not found" \
	"${derr}: ${dexe}Fuzzel${bspan} could not be found. It is necessary to display the password prompt. Exiting."

	exit 1
}

# Check if cmd-polkit is installed.
command -v cmd-polkit-agent > /dev/null 2>&1 || {
	printf "%s: %scmd-polkit%s could not be found. It is necessary to interact with the Polkit system. Exiting.\n" "$err" "$exe" "$clr"

	notify "cmd-polkit not found" \
	"${derr}: ${dexe}cmd-polkit${bspan} could not be found. It is necessary to interact with the Polkit system. Exiting."

	exit 1
}

# Format parameters for passing to internal call.
params=""
for arg in "$@"; do
	params="$params '$arg'"
done

# Start cmd-polkit-agent with internal call.
eval "exec cmd-polkit-agent -s -c '$0 _CALLED_INTERNALLY $params *'"