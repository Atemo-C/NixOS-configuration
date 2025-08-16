#!/usr/bin/env dash

# Credits.
# • DASH:        http://gondor.apana.org.au/~herbert/dash
# • Dunst:       https://dunst-project.org
# • Hyprpaper:   https://github.com/hyprwm/hyprpaper
# • ImageMagick: https://imagemagick.org
# • Zenity:      https://gitlab.gnome.org/GNOME/zenity

# Exit codes.
# • 0: Success.
# • 1: Niri was not detected.
# • 2: A dependency was not detected.
# • 3: The selected image background was not a valid image.
# • 4: The background image was applied, but the lockscreen image was not updated.
# • 5: Success, but Hyprpaper needs to be restarted manually.
# • 6: The background image was applied, but the lockscreen image was not updated, and Hyprpaper nedes to be restarted manually.
# • 7: An error occured during the selection of the background image, or the background image selector was closed before selecting one.

# Text formatting shortcuts for console messages using `printf`.
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0)
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0)

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
derr="<b><span foreground='#ff0000'>Error:</span></b>"
dexe="<b><span foreground='#ffc000'>"
dico="<b><span foreground='#00ffff'>"
dwar="<b><span foreground='#ff0080'>Warning:</span></b>"

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s %sDunst%s was not found. Graphical notifications disabled.\n" \
	"$war" "$exe" "$clr"

	dunst_dep=false
}; [ "$dunst_dep" = false ] || { dunst_dep=true; }

# Functions for graphical notifications using dunstify.
errify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }
warify() { [ "$dunst_dep" = "false" ] || dunstify "$1" "$2"; }

# Check for any command-line arguments.
[ "$#" -ne 0 ] && {
	printf "%s This script does not support command-line arguments. Ignoring.\n" "$war"

	warnify "Arguments not supported" \
	"${dwar} This script does not support command-line arguments. Ignoring."
}

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s This script must be used in the %sNiri%s Wayland compositor. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Not using Niri" \
	"${derr} This script must be used in the ${dexe}Niri${bspan} Wayland compositor. Exiting."

	exit 1
}

# Check if Hyprpaper is installed.
command -v hyprpaper > /dev/null 2>&1 || {
	printf "%s %sHyprpaper%s not found. It is needed to apply the background image. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Hyprpaper not found" \
	"${derr} ${dexe}Hyprpaper${bspan} not found. It is needed to apply the background image. Exiting."

	exit 2
}

# Check if Zenity is installed.
command -v zenity > /dev/null 2>&1 || {
	printf "%s %sZenity%s not found. It is needed to select the background image. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Zenity not found" \
	"${derr} ${dexe}Zenity${bspan} not found. It is needed to select the background image. Exiting."

	exit 2
}

# Check if ImageMagick is installed.
command -v magick > /dev/null 2>&1 || {
	printf "%s %sImageMagick%s not found. It is needed to create the modified lockscreen background image and to check if the selected image is valid in the first place. The normal background image will be used for it instead, and it will simply be assumed that the image is valid. Continuing.\n" \
	"$war" "$exe" "$clr"

	warify "ImageMagick not found" \
	"${dwar} ${dexe}ImageMagick${bspan} not found. It is needed to create the modified lockscreen background image and to check if the selected image is valid in the first place. The normal background image will be used for it instead, and it will simply be assumed that the image is valid. Continuing."

	magick_dep=false
}; [ "$magick_dep" = false ] || { magick_dep=true; }

# Check for a valid directory to start the file picker in.
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

# If possible, check if the selected file is a valid image.
out=$?
[ "$out" = "0" ] && [ "$magick_dep" = "true" ] && {
	magick identify "$background" > /dev/null 2>&1 || {
		printf "%s %s%s%s is not a valid image. Exiting.\n" \
		"$err" "$ico" "$background" "$clr"

		errify "Invalid image" \
		"${derr} ${dico}${background}${bspan} is not a valid image. Exiting."

		exit 3
	}
}

# Copy the background image to Hyprpaper's configuration file's directory to ensure its permanence.
cp "$background" "$HOME/.config/hypr/backgroundimage" || {
	printf "%s %s%s%s image could not be copied. Using the original image's path.\n" \
	"$war" "$ico" "$background" "$clr"

	warify "Background image not copied" \
	"${dwar} ${dico}${background}${bspan} could not be copied. Using the original image's path."

	original=true
}; [ "$original" = "true" ] || { background="$HOME/.config/hypr/backgroundimage"; }

# Write the output to Hyprpaper's configuration file and restart it.
[ "$out" = "0" ] && {
	{
		printf "preload = %s\n" "$background"
		printf "wallpaper = ,%s\n" "$background"
		printf "splash = false\n"
		printf "ipc = off\n"
	} > "$HOME/.config/hypr/hyprpaper.conf"

	# Close Hyprpaper if it is alreadi running.
	pkill --exact "hyprpaper" || true;

	# Wait until Hyprpaper is no longer running before restarting it.
	timeout=5
	count=0
	while pgrep -x "hyprpaper" > /dev/null 2>&1 && [ "$count" -lt $((timeout*50)) ]; do
		sleep 0.05
		count=$((count+1))
	done

	# Check if Hyprpaper is still running after the timeout.
	pgrep -x "hyprpaper" > /dev/null 2>&1 && {
		printf "%s %sHyprpaper%s could not be terminated. Please try to restart it yourself. Proceeding to apply the lockscreen image…" \
		"$war" "$exe" "$clr"

		warify "Hyprpaper not terminated" \
		"${dwar}: ${dexe}Hyprpaper${bspan} could not be terminated. Please try to restart it yourself. Proceeding to apply the lockscreen image…"

		hyprpaper_is_kill=false
	}; [ "$hyprpaper_is_kill" = "false" ] || { hyprpaper_is_kill=true; }

	# Start Hyprpaper with the updated configuration.
	[ "$hyprpaper_is_kill" = "true" ] && { nohup hyprpaper > /dev/null 2>&1; }

	# Create a blurred and slightly darkened version of the lockscreen image background.
	[ "$magick_dep" = "true" ] && {
		magick "$background" -brightness-contrast -9 -gaussian-blur 9x9 "$OHME/.config/hypr/lockscreenimage.jpg" || {
			printf "%s An error occured during the creation of the lockscreen image. Using a non-transformed image instead.\n" "$war"

			warify "Lockscreen image creation failure" \
			"${dwar} An error occured during the creation of the lockscreen image. Using a non-transformed image instead."

			magick "$background" -quality 100 "$HOME/.config/hypr/lockscreenimage.jpg"

			[ "$hyprpaper_is_kill" = "false" ] && { exit 6; }
		}
		[ "$hyprpaper_is_kill" = "false" ] && { exit 5; }
		exit
	}
	exit 4
}

# If an error occures or the file picker is closed, display an error message.
[ "$out" = "1" ] && {
	printf "%s An error occured during the selection of the background image, or the background image selector was closed before selecting one. Exiting.\n" "$err"

	notify "Error" \
	"${derr}: An error occured during the selection of the background image, or the background image selector was closed before selecting one. Exiting."

	exit 7
}