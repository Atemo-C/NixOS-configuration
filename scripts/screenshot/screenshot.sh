#!/run/current-system/sw/bin/dash

# Create a function to print out the help message.
helpme() {
	# Text formatting shortcuts for console messages.
	ARG=$(tput bold; tput setaf 2)
	SARG=$(tput bold; tput setaf 5)
	BOL=$(tput bold)
	CLR=$(tput sgr0)
	DIM=$(tput dim)
	CMD=$(tput bold; tput setaf 3)
	ICO=$(tput bold; tput setaf 6)

	# Print the help message.
	printf "\n┌─ %sDescription%s ────────────────────────────────────────────────────────────────┐\n" "$BOL" "$CLR"
	printf "│ This script helps taking screenshots in the Niri Wayland compositor.         │\n"
	printf "│ It uses Niri's built-in screenshot utility, extended with external ones.     │\n"
	printf "│                                                                              │\n"
	printf "│ When saving a screenshot, the overview will rapidly be toggled once.         │\n"
	printf "│ This updates Niri's even stream, allowing grep to catch screenshot events.   │\n"
	printf "│                                                                              │\n"
	printf "│ Save path, file name, and others are configurable within the script.         │\n"
	printf "│                                                                              │\n"
	printf "├─ %sDependencies%s ───────────────────────────────────────────────────────────────┤\n" "$BOL" "$CLR"
	printf "│ • %sDASH%s         │ For fast, POSIX-compliant shell script execution.           │\n" "$CMD" "$CLR"
	printf "│ • %sNiri%s         │ This script is made for and relies on Niri.                 │\n" "$CMD" "$CLR"
	printf "│ • %swl-clipboard%s │ %s(Recommended)%s For saving screenshots with wl-paste.         │\n" "$CMD" "$CLR" "$DIM" "$CLR"
	printf "│ • %sOxipng%s       │ %s(Optional)%s For optimizing saved PNG screenshots.            │\n" "$CMD" "$CLR" "$DIM" "$CLR"
	printf "│ • %slibwebp%s      │ %s(Optional)%s For converting saved screenshots to WebP.        │\n" "$CMD" "$CLR" "$DIM" "$CLR"
	printf "│                                                                              │\n"
	printf "├─ %sArguments%s %s(followed by one sub-argument)%s ───────────────────────────────────┤\n" "$BOL" "$CLR" "$DIM" "$CLR"
	printf "│ %s--help%s | %s-help%s | %shelp%s | %s--h%s | %s-h%s | %sh%s                                         │\n" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR"
	printf "│  Display this message.                                                       │\n"
	printf "│                                                                              │\n"
	printf "│ %s--copy%s | %s-copy%s | %scopy%s | %s--c%s | %s-c%s | %sc%s                                         │\n" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR"
	printf "│  Take a screenshot and copy it to the clipboard.                             │\n"
	printf "│                                                                              │\n"
	printf "│ %s--save%s | %s-save%s | %ssave%s | %s--s%s | %s-s%s | %ss%s                                         │\n" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR"
	printf "│  1) Save a screenshot and paste it into a PNG file;                          │\n"
	printf "│  2) Optimize the PNG file losslessly with Oxipng %s(optional)%s;                 │\n" "$DIM" "$CLR"
	printf "│  3) Convert the PNG file losslessly to a WebP one %s(optional)%s;                │\n" "$DIM" "$CLR"
	printf "│                                                                              │\n"
	printf "├─ %sSub-arguments%s %s(preceeded by one sub-argument)%s ──────────────────────────────┤\n" "$BOL" "$CLR" "$DIM" "$CLR"
	printf "│ %sarea%s | %sfree%s | %sregion%s                                                         │\n" "$SARG" "$CLR" "$SARG" "$CLR" "$SARG" "$CLR"
	printf "│  Take a screenshot of any free area on a display.                            │\n"
	printf "│                                                                              │\n"
	printf "│ %swindow%s | %sapplication%s | %sapp%s | %sprogram%s                                         │\n" "$SARG" "$CLR" "$SARG" "$CLR" "$SARG" "$CLR" "$SARG" "$CLR"
	printf "│  Take a screenshot of the currently active window.                           │\n"
	printf "│                                                                              │\n"
	printf "│ %smonitor%s | %sdisplay%s | %sscreen%s | %soutput%s                                          │\n" "$SARG" "$CLR" "$SARG" "$CLR" "$SARG" "$CLR" "$SARG" "$CLR"
	printf "│  Take a screenshot of the currently active monitor.                          │\n"
	printf "│                                                                              │\n"
	printf "├─ %sExamples%s ───────────────────────────────────────────────────────────────────┤\n" "$BOL" "$CLR"
	printf "│ To copy a free area screenshot to the clipboard:                             │\n"
	printf "│  %s./screenshot.sh%s %s--copy%s %sarea%s                                                 │\n" "$ICO" "$CLR" "$ARG" "$CLR" "$SARG" "$CLR"
	printf "│                                                                              │\n"
	printf "│ To save a screenshot of the currently active monitor:                        │\n"
	printf "│  %s./screenshot.sh%s %s--save%s %smonitor%s                                              │\n" "$ICO" "$CLR" "$ARG" "$CLR" "$SARG" "$CLR"
	printf "│                                                                              │\n"
	printf "│                                                                              │\n"
	printf "│ Invalid command due to wrong argument order:                                 │\n"
	printf "│  %s./screenshot.sh%s %swindow%s %s--save%s                                               │\n" "$ICO" "$CLR" "$SARG" "$CLR" "$ARG" "$CLR"
	printf "│                                                                              │\n"
	printf "│ Invalid command due to too many arguments:                                   │\n"
	printf "│  %s./screenshot.sh%s %s--copy%s %s--save%s %sarea%s                                          │\n" "$ICO" "$CLR" "$ARG" "$CLR" "$ARG" "$CLR" "$SARG" "$CLR"
	printf "│ %s(Note that saved screenshots are also copied to the clipboard by default.)%s   │\n" "$DIM" "$CLR"
	printf "└──────────────────────────────────────────────────────────────────────────────┘\n\n"
}

# Ceck if the number of arguments is greater than 2.
[ "$#" -gt 2 ] && {
	printf "Invalid number of arguments (%d). See the help below.\n\n" "$#"
	helpme
	exit 1
}

# Check if `niri` is the active Wayland compositor.
[ "$XDG_CURRENT_DESKTOP" = "niri" ] || {
	printf "Niri is not the running desktop.\nIf it is, check that %s is correct.\n" "$XDG_CURRENT_DESKTOP"
	exit 1
}

# Check for the main arguments.
case "$1" in
	# Check for the help arguments.
	"--help"|"-help"|"help"|"--h"|"-h"|"h")
		# Display the help message and exit.
		helpme && exit 0
	;;

	# Check for the copy arguments.
	"--copy"|"-copy"|"copy"|"--c"|"-c"|"c")
		# Check for the sub-arguments.
		case "$2" in
			"area"|"free"|"region") type="screenshot";;
			"window"|"application"|"app"|"program") type="screenshot-window";;
			"monitor"|"display"|"screen"|"output") type="screenshot-screen";;

			# Check for missing sub-argument.
			"")
				# Display the help message and exit.
				printf "No sub-argument was given; See the help below.\n"
				helpme && exit 1
			;;

			# Check for invalid sub-arguments.
			*)
				# Display the help message and exit.
				printf "Invalid sub-argument '%s'; See the help below.\n" "$2"
				helpme && exit 1
			;;
		esac

		# Take the screenshot.
		niri msg action "$type" || {
			printf "Could not take the screenshot; Exiting…\n"
			exit 1
		}
		exit 0
	;;

	# Check for the save arguments.
	"--save"|"-save"|"save"|"--s"|"-s"|"s")
		# Check for the sub-arguments.
		case "$2" in
			"area"|"free"|"region") type="screenshot";;
			"window"|"application"|"app"|"program") type="screenshot-window";;
			"monitor"|"display"|"screen"|"output") type="screenshot-screen";;

			# Check for missing sub-argument.
			"")
				# Display the help message and exit.
				printf "No sub-argument was given; See the help below.\n"
				helpme && exit 1
			;;

			# Check for invalid sub-arguments.
			*)
				# Display the help message and exit.
				printf "Invalid sub-argument '%s'; See the help below.\n" "$2"
				helpme && exit 1
			;;
		esac

		# Check if `wl-paste` is available.
		command -v wl-paste >/dev/null 2>&1 || {
			printf "wl-paste not found; It is necessary to save the screenshot. Exiting…\n"
			exit 1
		}

		# Check if `oxipng` is available.
		command -v oxipng >/dev/null 2>&1 || {
			printf "oxipng not found; PNG optimizpation ignored.\n"
			has_oxipng=false
		}

		# Check if `cwebp` is available.
		command -v cwebp >/dev/null 2>&1 || {
			printf "cwebp not found; WebP convertion disbaled.\n"
			has_cwebp=false
		}

		# Set the file path of the PID file.
		PID_FILE="/tmp/niri_screenshot.pid"

		# Check if a previous instance of this script is running.
		# If so, terminate it.
		[ -f "$PID_FILE" ] && {
			OLD_PID=$(cat "$PID_FILE")
			kill -0 "$OLD_PID" 2>/dev/null && kill "$OLD_PID"
		}

		# Print the new PID to the PID file.
		printf "%s\n" "$$" > "$PID_FILE"

		# Take the screenshot.
		tookscreenshot=0
		niri msg action "$type" || {
			printf "Could not take the screenshot. Exiting.\n"
			exit 1
		}

		# Generous 30 seconds timeout to check if the screenshot has been captured.
		timeout 30s niri msg event-stream | grep -q "Screenshot captured" &
		GREP_PID=$!

		# Run dummy niri actions to update the even stream for grep.
		while true; do
			niri msg action toggle-overview && niri msg action toggle-overview
			sleep 30
		done &
		LOOP_PID=$!
		# Wait for grep to detect the screenshot event.
		# In any case, kill the previous loop of dummy events.
		if wait $GREP_PID;
		then
			tookscreenshot=1
			kill $LOOP_PID
		else
			kill $LOOP_PID
			exit 1
		fi

		# If a screenshot has been taken, initiate the saving and processing actions.
		[ "$tookscreenshot" = "1" ] && {
			# Check for valid directories to save the screenshot to.
			scrdir="$HOME/Images/Screenshots"
			[ -d "$scrdir" ] || scrdir="$XDG_PICTURES_DIR/"
			[ -d "$scrdir" ] || scrdir="$HOME/"
			cd "$scrdir" || {
				printf "Could not navigate to a suitable save directory… How?\n"
				exit 1
			}

			# Set the screenshot's name.
			image=$(date +'Screenshot_%d-%m-%Y_%H-%M-%S')

			# Paste the image into a PNG file.
			wl-paste > "$image".png || {
				printf "Could not save the image to a PNG file. Exiting.\n"
				exit 1
			}

			# Optimize the image with Oxipng.
			[ "$has_oxipng" != "false" ] && oxipng --strip all "$image".png >/dev/null 2>&1 \
			|| printf "Could not optimize the PNG file; Ignoring.\n"

			# Convert the image to WebP, and delete the PNG file.
			[ "$has_cwebp" != "false" ] && {
				if cwebp "$image".png -lossless -o "$image".webp >/dev/null 2>&1;
				then
					rm "$image".png
					exit 0
				else
					printf "Could not convert the image to WebP, keeping the PNG one.\n"
					exit 2
				fi
			}
		}
	;;

	# Check for missing argument.
	"")
		# Display the help message and exit.
		printf "No argument was given; See the help below.\n"
		helpme && exit 1
	;;

	# Check for invalid arguments.
	*)
		# Display the help message and exit.
		printf "Invalid argument '%s'; See the help below.\n" "$1"
		helpme && exit 1
	;;
esac