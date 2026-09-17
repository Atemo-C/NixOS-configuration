{ config, pkgs, ... }: let midiplus-smartpad-macropad = pkgs.writers.writeDashBin "midiplus-smartpad-macropad"
''
	# Try to automatically detect the correct port.
	# If two identical pads are connected, the first one is selected.
	port=$(${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -l | ${pkgs.lib.getBin pkgs.gawk}/bin/awk '/SmartPAD/ {print $2}')

	# Exit if no port has been detected.
	# This should usually never happen in normal cases, but if the pad is detected by udev yet cannot communicate properly, this may be useful to have.
	[ -z "$port" ] && {
		echo "[ERR] No MiDiPLUS SmartPAD has been detected. Exiting."
		exit 1
	}

	# Function to clear the pad's lights.
	clearlights() {
		row=0
		while [ "$row" -lt 8 ]; do
			col=0
			while [ "$col" -lt 8 ]; do
				key=$((row * 16 + col))
				hex=$(printf "%02X" "$key")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 $hex 00" || {
					echo "[ERR] No MiDiPLUS SmartPAD has been detected. Exiting."
					exit 1
				}
				col=$((col + 1))
			done
			row=$((row + 1))
		done
	}

	# Clear the pad's lights.
	clearlights

	# Human-readable color names for the pad's lights.
	white="0f"
	yellow="1f"
	cyan="2f"
	magenta="3f"
	blue="4f"
	green="5f"
	red="6f"

	# Set the desired colors across the matrix.
	#
	# Key matrix:             │ Lights layout:
	# 00 01 02 03 04 05 06 07 │ - - - - - - - -
	# 10 11 12 13 14 15 16 17 │ - - - - - - - -
	# 20 21 22 23 24 25 26 27 │ M M M W W W R R
	# 30 31 32 33 34 35 36 37 │ B - - - - - - -
	# 40 41 42 43 44 45 46 47 │ Y C C G R B B M
	# 50 51 52 53 54 55 56 57 │ - - - - - - - -
	# 60 61 62 63 64 65 66 67 │ - - - - - C G M
	# 70 71 72 73 74 75 76 77 │ G Y R - - C G M
	# Row 3
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 20 $magenta"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 21 $magenta"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 22 $magenta"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 23 $white"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 24 $white"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 25 $white"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 26 $red"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 27 $red"

	# Row 4
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 30 $blue"

	# Row 5
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 40 $yellow"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 41 $cyan"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 42 $cyan"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 43 $green"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 44 $red"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 45 $blue"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 46 $blue"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 47 $magenta"

	# Row 7
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 65 $cyan"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 66 $green"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 67 $magenta"

	# Row 8
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 70 $green"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 71 $yellow"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 72 $red"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 75 $cyan"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 76 $green"
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 77 $magenta"

	# Set the initial values to -1 per knob to avoid action on the first event.
	prev_0=-1 prev_1=-1 prev_2=-1 prev_3=-1 prev_4=-1 prev_5=-1 prev_6=-1 prev_7=-1

	# Take desired outputs from the MiDi controller.
	${pkgs.lib.getBin pkgs.alsa-utils}/bin/aseqdump -p "SmartPAD" | \
	while IFS=" ," read -r src ev1 ev2 ch label1 data1 label2 data2 rest; do
		# Read relevant outputs and execute the desired macro.
		# To see which one is pressed, you can run `aseqdump -p "SmartPAD"` separately.
		# And to see a list of available input event codes:
		# https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h
		case "$ev1 $ev2 $data1" in
			# Wave emote (Vintage Story)
			"Note on 32")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 20 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 17:1 17:0 30:1 30:0 47:1 47:0 18:1 18:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 20 $magenta"
			;;

			# Cheer emote (Vintage Story)
			"Note on 33")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 21 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 46:1 46:0 35:1 35:0 18:1 18:0 18:1 18:0 19:1 19:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 21 $magenta"
			;;

			# Laugh emote (Vintage Story)
			"Note on 34")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 22 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 38:1 38:0 30:1 30:0 22:1 22:0 34:1 34:0 35:1 35:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 22 $magenta"
			;;

			# Nod emote (Vintage Story)
			"Note on 35")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 23 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 49:1 49:0 24:1 24:0 32:1 32:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 23 $white"
			;;

			# Bow emote (Vintage Story)
			"Note on 36")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 24 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 48:1 48:0 24:1 24:0 17:1 17:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 24 $white"
			;;

			# Shrug emote (Vintage Story)
			"Note on 37")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 25 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 31:1 31:0 35:1 35:0 19:1 19:0 22:1 22:0 34:1 34:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 25 $white"
			;;

			# Facepalm emote (Vintage Story)
			"Note on 38")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 26 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 33:1 33:0 30:1 30:0 46:1 46:0 18:1 18:0 25:1 25:0 30:1 30:0 38:1 38:0 50:1 50:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 26 $red"
			;;

			# Rage emote (Vintage Story)
			"Note on 39")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 27 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 19:1 19:0 30:1 30:0 34:1 34:0 18:1 18:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 27 $red"
			;;

			# Cry emote (Vintage Story)
			"Note on 48")
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 30 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 46:1 46:0 19:1 19:0 21:1 21:0 28:1 28:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 30 $blue"
			;;

			# Open / Close CD tray.
			"Note on 64" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 40 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 161:1 161:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 40 $yellow"
			;;

			# Rewind media.
			"Note on 65" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 41 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 168:1 168:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 41 $cyan"
			;;

			# Forward media.
			"Note on 66" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 42 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 208:1 208:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 42 $cyan"
			;;

			# Play / Pause media.
			"Note on 67" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 43 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 164:1 164:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 43 $green"
			;;

			# Stop media.
			"Note on 68" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 44 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 166:1 166:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 44 $red"
			;;

			# Previous media.
			"Note on 69" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 45 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 165:1 165:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 45 $blue"
			;;

			# Next media.
			"Note on 70" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 46 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 163:1 163:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 46 $blue"
			;;

			# Soft loop media (stop then play).
			"Note on 71" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 47 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 32 166:1 166:0 164:1 164:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 47 $magenta"
			;;

			# Start OBS recording.
			"Note on 112" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 70 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 56:1 125:1 19:1 19:0 125:0 56:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 70 $green"
			;;

			# Pause / Resume OBS recording.
			"Note on 113" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 71 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 56:1 125:1 25:1 25:0 125:0 56:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 71 $yellow"
			;;

			# Stop OBS recording.
			"Note on 114" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 72 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 56:1 125:1 31:1 31:0 125:0 56:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 72 $red"
			;;

			# Copy area screenshot.
			"Note on 117" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 75 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 210:1 210:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 75 $cyan"
			;;

			# Copy window screenshot.
			"Note on 118" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 76 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 42:1 210:1 210:0 42:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 76 $green"
			;;

			# Copy fullscreen screenshot.
			"Note on 119" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 77 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 29:1 210:1 210:0 29:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 77 $magenta"
			;;

			# Save area screenshot.
			"Note on 101" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 65 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 125:1 210:1 210:0 125:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 65 $cyan"
			;;

			# Save window screenshot.
			"Note on 102" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 66 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 125:1 42:1 210:1 210:0 42:0 125:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 66 $green"
			;;

			# Save fullscreen screenshot.
			"Note on 103" )
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 67 00"
				${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 125:1 29:1 210:1 210:0 29:0 125:0
				sleep 0.1
				${pkgs.lib.getBin pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 67 $magenta"
			;;

			# Output volume up and down (•) 1.
			"Control change 0" )
			new_value="$data2"
			{ [ "$prev_0" -eq -1 ] || {
				# Volume up.
				[ "$new_value" -gt "$prev_0" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 115:1 115:0; }

				# Volume down.
				[ "$new_value" -lt "$prev_0" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 114:1 114:0; }
				[ "$new_value" -eq "$prev_0" ] && {

					# Volume up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 115:1 115:0; }

					# Volume down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 114:1 114:0; }
				}
			}; prev_0="$new_value"; }
			;;

			# Media volume up and down on (•) 2.
			"Control change 1" )
			new_value="$data2"
			{ [ "$prev_1" -eq -1 ] || {
				# Volume up.
				[ "$new_value" -gt "$prev_1" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 42:1 115:1 115:0 42:0; }

				# Volume down.
				[ "$new_value" -lt "$prev_1" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 42:1 114:1 114:0 42:0; }
				[ "$new_value" -eq "$prev_1" ] && {

					# Volume up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 42:1 115:1 115:0 42:0; }

					# Volume down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 42:1 114:1 114:0 42:0; }
				}
			}; prev_1="$new_value"; }
			;;

			# Input volume up and down on (•) 3.
			"Control change 2" )
			new_value="$data2"
			{ [ "$prev_2" -eq -1 ] || {
				# Volume up.
				[ "$new_value" -gt "$prev_2" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 125:1 115:1 115:0 125:0; }

				# Volume down.
				[ "$new_value" -lt "$prev_2" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 125:1 114:1 114:0 125:0; }
				[ "$new_value" -eq "$prev_2" ] && {

					# Volume up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 125:1 115:1 115:0 125:0; }

					# Volume down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 2 125:1 114:1 114:0 125:0; }
				}
			}; prev_2="$new_value"; }
			;;

			# External display brightness control on (•) 7.
			"Control change 6" )
			new_value="$data2"
			{ [ "$prev_6" -eq -1 ] || {
				# Brightness up.
				[ "$new_value" -gt "$prev_6" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 24 42:1 225:1 225:0 42:0; }

				# Brightness down.
				[ "$new_value" -lt "$prev_6" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 24 42:1 224:1 224:0 42:0; }
				[ "$new_value" -eq "$prev_6" ] && {

					# Brightness up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 24 42:1 225:1 225:0 42:0; }

					# Brightness down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key -d 24 42:1 224:1 224:0 42:0; }
				}
			}; prev_6="$new_value"; }
			;;

			# Internal display brightness control on (•) 8.
			"Control change 7" )
			new_value="$data2"
			{ [ "$prev_7" -eq -1 ] || {
				# Brightness up.
				[ "$new_value" -gt "$prev_7" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 225:1 225:0; }

				# Brightness down.
				[ "$new_value" -lt "$prev_7" ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 224:1 224:0; }
				[ "$new_value" -eq "$prev_7" ] && {

					# Brightness up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 225:1 225:0; }

					# Brightness down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.lib.getBin pkgs.ydotool}/bin/ydotool key 224:1 224:0; }
				}
			}; prev_7="$new_value"; }
			;;
		esac
	done

	exit
'';
in {
	# Add the script as a global executable.
	environment.systemPackages = [ midiplus-smartpad-macropad ];

	# Enable ydotool, which is necessary for the macro actions.
	programs.ydotool.enable = true;

	# Add the user to the `ydotool` and `input` groups.
	users.users.${config.user.name}.extraGroups = [ "ydotool" "input" ];

	# Make this a systemd service. Is this necessary?
	# Technically, no, but it sure is a lot more convenient.
	systemd.services.midiplus-smartpad-macropad = {
		description = "MiDiPLUS SmartPAD macropad";
		serviceConfig = {
			Type = "simple";
			Environment = [ "YDOTOOL_SOCKET=/run/ydotoold/socket" ];
			# Note for the curious ones:
			# The MiDiPLUS SmartPAD has a mandatory startup animation that lasts slightly less than 2 seconds,
			# and only after that is it able to communicate with the computer.
			# So, the timing here is not coincidental and is not fragile.
			ExecStartPre = "${pkgs.lib.getBin pkgs.coreutils}/bin/sleep 2";
			ExecStart = "${midiplus-smartpad-macropad}/bin/midiplus-smartpad-macropad";
			KillMode = "control-group";
		};
	};

	# Automatically start when the device is connected.
	services.udev.extraRules = ''
		ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1acc", ATTR{idProduct}=="3801", \
			TAG+="systemd", \
			RUN+="${pkgs.lib.getBin pkgs.systemd}/bin/systemctl restart midiplus-smartpad-macropad.service"

		ACTION=="remove", SUBSYSTEM=="usb", ENV{PRODUCT}=="1acc/3801/*", \
			RUN+="${pkgs.lib.getBin pkgs.systemd}/bin/systemctl stop midiplus-smartpad-macropad.service"
	'';
}