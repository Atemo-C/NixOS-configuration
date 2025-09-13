#!/usr/bin/env dash

# This script was written for my NixOS configuration.
# https://github.com/Atemo-C/NixOS-configuration/blob/main/scripts/background.sh
#
# Required dependencies
#──────────────────────
# • DASH        http://gondor.apana.org.au/~herbert/dash
# • Hyprpaper   https://github.com/hyprwm/hyprpaper
# • ImageMagick https://imagemagick.org
# • Niri        https://github.com/YaLTeR/niri
# • Zenity      https://gitlab.gnome.org/GNOME/zenity
#
# Recommended dependencies
#─────────────────────────
# • Dunst https://dunst-project.org
#
# Exit codes
#───────────
# ✔ [0]  Sucess.
# ✘ [1]  The Niri Wayland compositor was not detected.
# ✘ [2]  Hyprpaper was not detected.
# ✘ [3]  Zenity was not detected.
# ✘ [4]  ImageMagick was not detected.
# ✘ [5]  The selected file does not seem to be a valid image.
# ✘ [6]  Hyprpaper's configuration could not be updated.
# ✓ [7]  The lockscreen image was updated, but Hyprland needs to be manually restarted.
# ✓ [8]  The lockscreen image uses the normal wallpaper, and Hyprland needs to be manually restarted.
# ~ [9]  The lockscreen image could not be updated.
# ~ [10] The lockscreen image could not be updated, and Hyprland needs to be manually restarted.

# Text formatting shortcuts for console messages using `printf`.
clr=$(tput sgr0)
err=$(tput bold; tput setaf 1)Error$(tput sgr0):
exe=$(tput bold; tput setaf 3)
ico=$(tput bold; tput setaf 6)
war=$(tput bold; tput setaf 5)Warning$(tput sgr0):

# Text formatting for graphical notifications using `dunstify`.
bspan="</span></b>"
derr="<b><span foreground='#ff0000'>Error</span></b>:"
dexe="<b><span foreground='#ffc000'>"
dico="<b><span foreground='#00ffff'>"
dwar="<b><span foreground='#ff0080'>Warning</span></b>:"

# Check if Dunst is installed.
command -v dunstify > /dev/null 2>&1 || {
	printf "%s %sDunst%s was not found. Graphical notifications disabled. Continuing.\n" \
	"$war" "$exe" "$clr"

	dunst_dep=false
}

# Functions for graphical notifications using dunstify.
errify() { [ "$dunst_dep" = "false" ] || dunstify -u critical "$1" "$2"; }
warify() { [ "$dunst_dep" = "false" ] || dunstify "$1" "$2"; }

# Check for any command-line arguments.
[ "$#" -ne 0 ] && {
	printf "%s This script does not support command-line arguments. Ignoring.\n" "$war"

	warify "Arguments not supported" \
	"${dwar} This script does not support command-line arguments. Ignoring."
}

# Check if Niri is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "%s This script has been designed for the %sNiri%s Wayland compositor. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Not using Niri" \
	"${derr} This script has been designed for the %sNiri%s Wayland compositor. Exiting."

	exit 1
}

# Check if Hyprpaper is installed.
command -v hyprpaper > /dev/null 2>&1 || {
	printf "%s %sHyprpaper%s not found. It is needed to apply the wallpaper. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Hyprpaper not found" \
	"${derr} ${dexe}Hyprpaper${bspan} not found. It is needed to apply the wallpaper. Exiting."

	exit 2
}

# Check if Zenity is installed.
command -v zenity > /dev/null 2>&1 || {
	printf "%s %sZenity%s not found. It is needed to select the wallpaper. Exiting.\n" \
	"$err" "$exe" "$clr"

	errify "Zenity not found" \
	"${derr} ${dexe}Zenity${bspan} not found. It is needed to select the wallpaper. Exiting."

	exit 3
}

# Check if ImageMagick is installed.
command -v magick > /dev/null 2>&1 || {
	printf "%s %sImageMagick%s not found. It is needed to create the modified lockscreen wallpaper, and to check if the selected file is a valid image. Exiting.\n" \
	"$war" "$exe" "$clr"

	warify "ImageMagick not found." \
	"${dwar} ${dexe}ImageMagick${bspan} not found. It is needed to create the modified lockscreen wallpaper, and to check if the selected file is a valid image. Exiting."

	exit 4
}

# Check for a valid directory to start the file picker in.
bgdir="$HOME/Images/Backgrounds/"
[ -d "$bgdir" ] || bgdir="$XDG_PICTURES_DIR/"
[ -d "$bgdir" ] || bgdir="$HOME/"

# Check if Hyprpaper's configuration file's directory exists; Create it if not.
[ -d "$HOME/.config/hypr" ] || { mkdir -p "$HOME/.config/hypr"; }

# Select the wallpaper to be used.
wallpaper=$(zenity \
	--file-selection \
	--filename="$bgdir" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a wallpaper"
)

out=$?

# If possible, check if the selected file is a valid image.
[ "$out" = "0" ] && {
	magick identify "$wallpaper" > /dev/null 2>&1 || {
		printf "%s %s%s%s is not a valid image. Exiting.\n" \
		"$err" "$ico" "$wallpaper" "$clr"

		errify "Invalid image" \
		"${derr} ${dico}${wallpaper}${bspan} is not a valid image. Exiting."

		exit 5
	}
}

# Copy the wallpaper to Hyprpaper's configuration file's directory to ensure its permanence.
cp "$wallpaper" "$HOME/.config/hypr/wallpaper" || {
	printf "%s %s%s%s image could not be copied. Using the original image's path.\n" \
	"$war" "$ico" "$wallpaper" "$clr"

	warify "Wallpaper image not copied" \
	"${dwar} ${dico}${wallpaper}${bspan} could not be copied. Using the original image's path."

	original=true
}; [ "$original" != "true" ] && { wallpaper="$HOME/.config/hypr/wallpaper"; }


# Write the output to Hyprpaper's configuration file.
[ "$out" = "0" ] && {
	{
		printf "preload = %s\n" "$wallpaper"
		printf "wallpaper = ,%s\n" "$wallpaper"
		printf "splash = false\n"
		printf "ipc = off\n"
	} > "$HOME/.config/hypr/hyprpaper.conf" || {
		printf "%s An error occured when writing the configuration file of %sHyprpaper%s. Exiting.\n" \
		"$err" "$exe" "$clr"

		errify "Could not update configuration" \
		"${derr} An error occured when writing the configuration file of ${dexe}Hyprpaper${bspan}. Exiting."

		exit 6
	}

	# Close Hyprpaper if it is already running.
	pkill --exact "hyprpaper" || true;

	# Wait until Hyprpaper is no longer running before starting it with the updated configuration.
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
		"${dwar} ${dexe}Hyprpaper${bspan} could not be terminated. Please try to restart it yourself. Proceeding to apply the lockscreen image…"

		hyprpaper_is_kill=false
	}

	# Start Hyprpaper with the updated configuration.
	[ "$hyprpaper_is_kill" != "false" ] && nohup hyprpaper > /dev/null 2>&1 &

	# Create a blurred and slightly darkened version of the lockscreen image.
	magick "$wallpaper" -quality 100 -brightness-contrast -9 -gaussian-blur 7x7 \
	"$HOME/.config/hypr/lockscreenimage.jpg" || {
		printf "%s An error occured during the creation of the lockscreen image. Using the original image instead.\n" "$war"

		warify "Lockscreen image creation failure" \
		"${dwar} An error occured during the creation of the lockscreen image. Using the original image instead."

		magick "$wallpaper" -quality 100 "$HOME/.config/hypr/lockscreenimage.jpg" || {
			printf "%s An error occured when attempting to use the original image. Exiting.\n" "$err"
			[ "$hyprpaper_is_kill" = "false" ] && { exit 9; }

			exit 9
		}

		[ "$hyprpaper_is_kill" = "false" ] && { exit 8; }
	}

	[ "$hyprpaper_is_kill" = "false" ] && { exit 7; }

	exit 0
}

# If an error occurs or the file picker is closed, display an error message.
[ "$out" = "1" ] && {
	printf "%s An error occured during the selection of the wallpaper, or the selection was cancelled. Exiting.\n" "$err"

	errify "Error" \
	"${derr} An error occured during the selection of the wallpaper, or the selection was cancelled. Exiting"

	exit 10
}

# ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠗⣪⣵⣶⠞⣃⣄⡻⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⣾⣿⣿⠁⠚⠧⠿⠛⠜⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⡿⣛⣋⢅⣤⣷⡯⣥⣒⠎⣙⡛⠿⠿⠿⢋⡇⣿⣿
# ⣿⣿⣿⣿⣿⣿⣿⣿⢡⣴⣾⠏⣴⣯⣍⠻⣿⣮⠻⢷⣌⢻⣧⢰⣶⡟⡅⣿⣿
# ⣿⣿⣿⣿⣿⣿⡿⣥⣾⣿⠇⣾⢿⣧⣤⣤⣌⡟⢳⠿⠛⠀⣿⠸⢋⣼⣿⣿⣿
# ⣿⣿⣿⣿⣿⣿⠁⣿⣿⠏⣾⢟⣨⣛⠻⣛⣻⡻⣿⣶⣮⢐⢡⣾⡈⣿⣿⣿⣿
# ⣿⣿⣿⣿⣿⢒⠀⠿⡿⢸⡏⠼⢢⡩⣅⠈⢹⣿⢿⡛⢗⢸⢘⣟⣣⣿⣿⣿⣿
# ⣿⣿⣿⡿⣣⣿⢿⡷⣭⠘⡀⠐⣻⣷⠪⣛⠦⣤⣤⣬⡤⢠⡈⢼⣇⣿⣿⣿⣿
# ⣿⣿⡟⣰⣿⣿⣦⡛⢷⣾⣿⠡⣿⣿⣿⣶⣿⣷⣶⠶⣶⣆⢩⢸⣿⣿⣿⣿⣿
# ⣿⣿⢱⣿⣿⣿⣿⣿⡦⠙⣿⣟⠹⣿⣿⣿⣿⣯⣷⣿⣿⢣⣿⡇⢿⣿⣿⣿⣿
# ⣿⡏⣿⣿⣿⣿⣿⠟⣵⣷⠹⣿⣷⣤⣉⣥⣛⠘⣋⠛⢣⣿⣿⡇⣠⡹⣿⣿⣿
# ⣿⣧⠻⣿⣿⡿⢋⣾⣿⣿⣧⠹⠿⡿⠿⢿⣿⠿⢋⣔⣻⠿⣫⣾⣿⣿⡌⢿⣿
# I see you there, looking at my code.
# Lucky for you, you are not a deer.
# If you are… I believe you might like my truck.