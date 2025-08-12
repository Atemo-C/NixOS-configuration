#!/usr/bin/env dash

# Credits.
# • DASH:        http://gondor.apana.org.au/~herbert/dash
# • Dunst:       https://dunst-project.org
# • Hyprpaper:   https://github.com/hyprwm/hyprpaper
# • ImageMagick: https://imagemagick.org
# • Zenity:      https://gitlab.gnome.org/GNOME/zenity

# Text formatting shortcuts for console messages using `printf`.
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
derr="<b><span foreground='#ff0000'>Error</span></b>"
dexe="<b><span foreground='#ffc000'>"
dwar="<b><span foreground='#ff0080'>Warning</span></b>"

# Check for any argument that may be present.
[ "$#" -ne 0 ] && { printf "%s: This script does not support command-line arguments. Ignoring.\n" "$war"; }

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s: %sDunst%s could not be found. Graphical notifications disabled. Continuing.\n" "$war" "$exe" "$clr"

	dunst_dep=false
}; [ "$dunst_dep" = false ] || { dunst_dep=true; }

# Function for graphical notifications using dunstify.
notify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }
warify() { [ "$dunst_dep" = "false" ] || dunstify "$1" "$2"; }

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s: This script is made to be used within the %sNiri%s Wayland compositor. Exiting.\n" "$err" "$exe" "$clr"

	notify "Niri not detected" \
	"${derr}: This script is made to be used within the ${dexe}Niri${bspan} Wayland compositor. Exiting."

	exit 1
}

# Check if Zenity is installed.
command -v zenity > /dev/null 2>&1 || {
	printf "%s: %sZenity%s could not be found. It is needed to select a background image. Exiting.\n" "$err" "$exe" "$clr"

	notify "Zenity not found" \
	"${derr}: ${dexe}Zenity${bspan} could not be found. It is needed to select a background image. Exiting."

	exit 1
}

# Check if Hyprpaper is installed.
command -v hyprpaper > /dev/null 2>&1 || {
	printf "%s: %sHyprpaper%s could not be found. It is needed to apply the background image. Exiting.\n" "$err" "$exe" "$clr"

	notify "Hyprpaper not found" \
	"${derr}: ${dexe}Hyprpaper${bspan} could not be found. It is needed to apply the background image. Exiting."

	exit 1
}

# Check if ImageMagick is installed.
command -v magick > /dev/null 2>&1 || {
	printf "%s: %sImageMagick%s could not be found. It is needed to create the lockscreen background image. Ignoring.\n" "$war" "$exe" "$clr"

	notify "ImageMagick not found" \
	"${derr}: ${dexe}ImageMagick${bspan} could not be found. It is needed to create the lockscreen background image. Ignoring."

	magick_dep=false
}; [ "$magick_dep" = false ] || { magick_dep=true; }

# Check if my own backgrounds path exists, fallback to a standard directory if not.
bgdir="$HOME/Images/Backgrounds/"
[ -d "$bgdir" ] || bgdir="$XDG_PICTURES_DIR/"
[ -d "$bgdir" ] || bgdir="$HOME/"

# Check if Hyprpaper's configuration file's directory exists, create it if not.
[ -d "$HOME/.config/hypr" ] || { mkdir -p "$HOME/.config/hypr"; }

# Select the background image to be used.
background=$(zenity \
	--file-selection \
	--filename="$bgdir" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a background image"
)

# Check if the select file is a valid image.
out=$?
[ "$out" = "0" ] && {
	magick identify "$background" > /dev/null 2>&1 || {
		printf "%s: The selected file is not a valid image. Exiting.\n" "$err"

		notify "Invalid image" \
		"${derr}: The selected file is not a valid image. Exiting."

		exit 1
	}
}

# Copy the background image to Hyprpaper's configuration file's directory.
# This ensures that the backgroud image stays even if the original image disappears.
cp "$background" "$HOME/.config/hypr/backgroundimage" || {
	printf "%s: The background image could not be copied. Using the original image's path.\n" "$war"

	notify "Could not copy background image" \
	"${dwar}: The background image could not be copied. Using the original image's path."

	orig=true
}; [ "$orig" = "true" ] || { background="$HOME/.config/hypr/backgroundimage"; }

# Write the output to Hyprpaper's configuration file and restart it.
[ "$out" = "0" ] && {
	{
		printf "preload = %s\n" "$background"
		printf "wallpaper = ,%s\n" "$background"
		printf "splash = false\n"
		printf "ipc = off\n"
	} > "$HOME/.config/hypr/hyprpaper.conf"

	# Close Hyprpaper if it is already running.
	pkill --exact "hyprpaper" || true;

	# Wait until hyprpaper is no longer running before restarting it.
	timeout=5
	count=0
	while pgrep -x "hyprpaper" > /dev/null 2>&1 && [ $count -lt $((timeout*50)) ]; do
		sleep 0.05
		count=$((count+1))
	done

	# Check if hyprpaper is still running after the timeout.
	pgrep -x "hyprpaper" > /dev/null 2>&1 && {
		printf "%s: %sHyprpaper%s could not be terminated. Please try to terminate it yourself. Exiting." "$err" "$exe" "$clr"

		notify "Hyprpaper not terminated" \
		"${derr}: ${dexe}Hyprpaper${bspan} could not be terminated. Please try to terminate it yourself. Exiting."

		exit 1
	}

	# Start Hyprpaper with the updated configuration.
	nohup hyprpaper > /dev/null 2>&1 &

	# Create a blurred and slightly darkened version of the lockscreen image background.
	[ "$magick_dep" = "false" ] || {
		magick "$background" -brightness-contrast -9 -gaussian-blur 9x9 "$HOME/.config/hypr/lockscreenimage.jpg" || {
			printf "%s: An error occured during the creation process of the lockscreen image. Ignoring.\n" "$war"

			warify "Lockscreen image creation failure" \
			"${dwar}: An error occured during the creation process of the lockscreen image. Ignoring."
		}
		exit 2
	}
	exit
}

# If an error occurs or the file picker is closed, display an error message.
[ "$out" = "1" ] && {
	printf "%s: An error occured, or no background image was chosen.\n" "$err"

	notify "Error" \
	"${derr}: An error occured, or no background image was chosen."

	exit 1
}