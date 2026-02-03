#!/run/current-system/sw/bin/dash

# Check for any command-line arguments, and ignore them if any is detected.
[ "$#" -gt 0 ] && {
	printf "This script does not support command-line arguments. Ignoring.\n"
	nohup "$0" >/dev/null 2>&1 & exit
}

# Check if `niri` is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "Niri is not the running desktop.\nIf it is, check that %s is correct.\n" "$XDG_CURRENT_DESKTOP"
	exit 1
}

# Check if `wbg` is available.
command -v wbg >/dev/null 2>&1 || {
	printf "wbg was not found; It is necessary to set a wallpaper. Exiting…\n"
	exit 1
}

# Check if `zenity` is available.
command -v zenity >/dev/null 2>&1 || {
	printf "Zenity was not found; It is necessary to pick a wallpaper. Exiting…\n"
	exit 1
}

# Check if `magick` is available.
command -v magick >/dev/null 2>&1 || {
	printf "ImageMagick was not found; It is necessary to check if the image file is valid, and to create an image Swaylock is happy about.\n"
	exit 1
}

# Check for a valid directory to start the file picker in.
bgdir="$HOME/Images/Backgrounds/"
[ -d "$bgdir" ] || bgdir="$XDG_PICTURES_DIR/"
[ -d "$bgdir" ] || bgdir="$HOME/"

# Check if the wallpaper directory exists; Create it if not.
[ -d "/etc/nixos/files/images/" ] || \
if mkdir -p "/etc/nixos/files/images/";
then
	printf "Wallpaper directory created in /etc/nixos/files/ with default permissions.\n"
else
	printf "Wallpaper directory could not be created in /etc/nixos/files/. Permission issue? Exiting…\n"
	exit 1
fi

# Select the wallpaper to be used.
wallpaper=$(zenity \
	--file-selection \
	--filename="$bgdir" \
	--file-filter="*.png *.jpg *.jpeg *.webp *.jxl" \
	--title="Select a wallpaper"
)
out=$?

# Action to run depending on if an image has been selected.
case "$out" in
	"0")
		# If possible, check if the selected file is a valid image.
		[ "$out" = "0" ] && {
			magick identify "$wallpaper" >/dev/null 2>&1 || {
				printf "%s does not appear to be a valid image. Exiting…\n" "$wallpaper"
				exit 1
			}
		}

		# Copy the wallpaper to `/etc/nixos/wallpaper/` to ensure its permanence.
		cp "$wallpaper" /etc/nixos/wallpaper/wallpaper || {
			printf "Could not copy the wallpaper over. Permission issue? Exiting…\n"
			exit 1
		}

		# Close wbg if it is already running.
		pkill --exact "wbg" || true;

		# Wait until wbg is no longer running before starting it with the updated configuration.
		timeout=5
		count=0
		while pgrep -x "wbg" >/dev/null 2>&1 && [ "$count" -lt $((timeout*50)) ]; do
			sleep 0.1
			count=$((count+1))
		done

		# Check if wbg is still running after the timeout.
		pgrep -x "wbg" >/dev/null 2>&1 && {
			printf "wbg could not be terminated. Please try to restart it yourself. The lockscreen image will still be 		updated.\n"
			wbg_closed=false
		}

		# Start wbg with the updated wallpaper.
		[ "$wbg_closed" != "false" ] && nohup wbg -s /etc/nixos/wallpaper/wallpaper >/dev/null 2>&1 &

		# Create a blurred and slightly darkened version of the lockscreen image.
		magick "$wallpaper" -quality 100 -brightness-contrast -9 -gaussian-blur 7x7 /etc/nixos/wallpaper/lockscreen.jpg || {
			printf "An error occured during the creation of the lockscreen image. Exiting.\n"
			exit 1
		}
	;;

	# If an error occurs or the file picker is closed, error out generically.
	"*")
		printf "An error occured during the selection of the wallpaper, or the selection was cancelled. Exiting…\n"
		exit 1
	;;
esac

###############################
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠗⣪⣵⣶⠞⣃⣄⡻⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿#
#⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⣾⣿⣿⠁⠚⠧⠿⠛⠜⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿#
#⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⡿⣛⣋⢅⣤⣷⡯⣥⣒⠎⣙⡛⠿⠿⠿⢋⡇⣿⣿#
#⣿⣿⣿⣿⣿⣿⣿⣿⢡⣴⣾⠏⣴⣯⣍⠻⣿⣮⠻⢷⣌⢻⣧⢰⣶⡟⡅⣿⣿#
#⣿⣿⣿⣿⣿⣿⡿⣥⣾⣿⠇⣾⢿⣧⣤⣤⣌⡟⢳⠿⠛⠀⣿⠸⢋⣼⣿⣿⣿#
#⣿⣿⣿⣿⣿⣿⠁⣿⣿⠏⣾⢟⣨⣛⠻⣛⣻⡻⣿⣶⣮⢐⢡⣾⡈⣿⣿⣿⣿#
#⣿⣿⣿⣿⣿⢒⠀⠿⡿⢸⡏⠼⢢⡩⣅⠈⢹⣿⢿⡛⢗⢸⢘⣟⣣⣿⣿⣿⣿#
#⣿⣿⣿⡿⣣⣿⢿⡷⣭⠘⡀⠐⣻⣷⠪⣛⠦⣤⣤⣬⡤⢠⡈⢼⣇⣿⣿⣿⣿#
#⣿⣿⡟⣰⣿⣿⣦⡛⢷⣾⣿⠡⣿⣿⣿⣶⣿⣷⣶⠶⣶⣆⢩⢸⣿⣿⣿⣿⣿#
#⣿⣿⢱⣿⣿⣿⣿⣿⡦⠙⣿⣟⠹⣿⣿⣿⣿⣯⣷⣿⣿⢣⣿⡇⢿⣿⣿⣿⣿#
#⣿⡏⣿⣿⣿⣿⣿⠟⣵⣷⠹⣿⣷⣤⣉⣥⣛⠘⣋⠛⢣⣿⣿⡇⣠⡹⣿⣿⣿#
#⣿⣧⠻⣿⣿⡿⢋⣾⣿⣿⣧⠹⠿⡿⠿⢿⣿⠿⢋⣔⣻⠿⣫⣾⣿⣿⡌⢿⣿#
###############################
# I see you there, looking at my code.
# Lucky for you, you are not a deer.
# If you are… I believe you might like my truck.