{ config, pkgs, ... }: let
	midiplus-smartpad-macropad = pkgs.writers.writeDashBin "midiplus-smartpad-macropad"
''
	# Human-readable colour shortcuts.
	white="0f"
	yellow="1f"
	cyan="2f"
	magenta="3f"
	blue="4f"
	green="5f"
	red="6f"

	# Port shortcut.
	# The correct port can be determined by running `amidi -l`.
	port="hw:3,0,0"

	# Clear all of the pad's lights.
	row=0
	while [ "$row" -lt 8 ]; do
		col=0
		while [ "$col" -lt 8 ]; do
			key=$((row * 16 + col))
			hex=$(printf "%02X" "$key")
			${pkgs.alsa-utils}/bin/amidi -p "$port" -S "80 $hex 00" || {
				echo "Device not detected. Exiting."
				exit 1
			}
			col=$((col + 1))
		done
		row=$((row + 1))
	done

	# Apply the desired colors.
	# Key matrix:             │ Current RGB layout:
	# 00 01 02 03 04 05 06 07 │ - - - - - - - -
	# 10 11 12 13 14 15 16 17 │ - - - - - - - -
	# 20 21 22 23 24 25 26 27 │ M M M W W W R R
	# 30 31 32 33 34 35 36 37 │ B - - - - - - -
	# 40 41 42 43 44 45 46 47 │ Y C C G R B B M
	# 50 51 52 53 54 55 56 57 │ - - - - - - - -
	# 60 61 62 63 64 65 66 67 │ W W W - - C G M
	# 70 71 72 73 74 75 76 77 │ G Y R - - C G M
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 20 $magenta"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 21 $magenta"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 22 $magenta"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 23 $white"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 24 $white"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 25 $white"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 26 $red"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 27 $red"

	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 30 $blue"

	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 40 $yellow"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 41 $cyan"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 42 $cyan"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 43 $green"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 44 $red"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 45 $blue"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 46 $blue"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 47 $magenta"

	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 60 $white"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 61 $white"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 62 $white"

	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 65 $cyan"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 66 $green"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 67 $magenta"

	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 70 $green"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 71 $yellow"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 72 $red"

	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 75 $cyan"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 76 $green"
	${pkgs.alsa-utils}/bin/amidi -p "$port" -S "90 77 $magenta"

	# Set the file path for the PID file.
	PID_FILE="/tmp/midiplus.pid"

	# Check if a previous instance of this script is running.
	# If so, terminate it.
	[ -f "$PID_FILE" ] && {
		OLD_PID=$(cat "$PID_FILE")
		kill -0 "$OLD_PID" 2>/dev/null && kill "$OLD_PID"
		pkill -9 -f "aseqdump -p SmartPAD" 2>/dev/null || true
	}

	# Print the new PID to the PID file.
	echo "$$" > "$PID_FILE"

	# Start the ydotool daemon if not already started.
	nohup ydotoold >/dev/null 2>&1 &

	# Set the initial values to -1 per knob to avoid action on the first event.
	prev_0=-1 prev_1=-1 prev_2=-1 prev_3=-1 prev_4=-1 prev_5=-1 prev_6=-1 prev_7=-1

	# Display outputs from the desired Midi controller.
	${pkgs.alsa-utils}/bin/aseqdump -p "SmartPAD" | \
	while IFS=" ," read -r src ev1 ev2 ch label1 data1 label2 data2 rest; do
		# Read relevant outputs.
		# To see which one is pressed, you can run `aseqdump -p "SmartPAD"`.
		# And to see a list of available input event codes:
		# https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h
		case "$ev1 $ev2 $data1" in
			# Wave emote (Vintage Story)
			"Note on 32") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 17:1 17:0 30:1 30:0 47:1 47:0 18:1 18:0 28:1 28:0 ;;

			# Cheer emote (Vintage Story)
			"Note on 33") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 46:1 46:0 35:1 35:0 18:1 18:0 18:1 18:0 19:1 19:0 28:1 28:0 ;;

			# Laugh emote (Vintage Story)
			"Note on 34") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 38:1 38:0 30:1 30:0 22:1 22:0 34:1 34:0 35:1 35:0 28:1 28:0 ;;

			# Nod emote (Vintage Story)
			"Note on 35") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 49:1 49:0 24:1 24:0 32:1 32:0 28:1 28:0 ;;

			# Bow emote (Vintage Story)
			"Note on 36") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 48:1 48:0 24:1 24:0 17:1 17:0 28:1 28:0 ;;

			# Shrug emote (Vintage Story)
			"Note on 37") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 31:1 31:0 35:1 35:0 19:1 19:0 22:1 22:0 34:1 34:0 28:1 28:0 ;;

			# Facepalm emote (Vintage Story)
			"Note on 38") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 33:1 33:0 30:1 30:0 46:1 46:0 18:1 18:0 25:1 25:0 30:1 30:0 38:1 38:0 50:1 50:0 28:1 28:0 ;;

			# Rage emote (Vintage Story)
			"Note on 39") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 19:1 19:0 30:1 30:0 34:1 34:0 18:1 18:0 28:1 28:0 ;;

			# Cry emote (Vintage Story)
			"Note on 48") ${pkgs.ydotool}/bin/ydotool key 20:1 20:0 53:1 53:0 18:1 18:0 50:1 50:0 24:1 24:0 20:1 20:0 18:1 18:0 57:1 57:0 46:1 46:0 19:1 19:0 21:1 21:0 28:1 28:0 ;;

			# Open / Close CD tray.
			"Note on 64" ) ${pkgs.ydotool}/bin/ydotool key 161:1 161:0 ;;

			# Rewind media.
			"Note on 65" ) ${pkgs.ydotool}/bin/ydotool key 168:1 168:0 ;;

			# Forward media.
			"Note on 66" ) ${pkgs.ydotool}/bin/ydotool key 208:1 208:0 ;;

			# Play / Pause media.
			"Note on 67" ) ${pkgs.ydotool}/bin/ydotool key 164:1 164:0 ;;

			# Stop media.
			"Note on 68" ) ${pkgs.ydotool}/bin/ydotool key 166:1 166:0 ;;

			# Previous media.
			"Note on 69" ) ${pkgs.ydotool}/bin/ydotool key 165:1 165:0 ;;

			# Next media.
			"Note on 70" ) ${pkgs.ydotool}/bin/ydotool key 163:1 163:0 ;;

			# Soft loop media (stop then play).
			"Note on 71" ) ${pkgs.ydotool}/bin/ydotool key 166:1 166:0 164:1 164:0 ;;

			# Start livestreaming (not implemented yet because not yet used).
			# Pause livestremaing (not implemented yet because not yet used).
			# Stop livestreaming (not implemented yet because not yet used).

			# Start OBS recording.
			"Note on 112" ) ${pkgs.ydotool}/bin/ydotool key 56:1 125:1 19:1 19:0 125:0 56:0 ;;

			# Pause / Resume OBS recording.
			"Note on 113" ) ${pkgs.ydotool}/bin/ydotool key 56:1 125:1 25:1 25:0 125:0 56:0 ;;

			# Stop OBS recording.
			"Note on 114" ) ${pkgs.ydotool}/bin/ydotool key 56:1 125:1 31:1 31:0 125:0 56:0 ;;

			# Copy area screenshot.
			"Note on 117" ) ${pkgs.ydotool}/bin/ydotool key 210:1 210:0 ;;

			# Copy window screenshot.
			"Note on 118" ) ${pkgs.ydotool}/bin/ydotool key 42:1 210:1 210:0 42:0 ;;

			# Copy fullscreen screenshot.
			"Note on 119" ) ${pkgs.ydotool}/bin/ydotool key 29:1 210:1 210:0 29:0 ;;

			# Save area screenshot.
			"Note on 101" ) ${pkgs.ydotool}/bin/ydotool key 125:1 210:1 210:0 125:0 ;;

			# Save window screenshot.
			"Note on 102" ) ${pkgs.ydotool}/bin/ydotool key 125:1 42:1 210:1 210:0 42:0 125:0 ;;

			# Save fullscreen screenshot.
			"Note on 103" ) ${pkgs.ydotool}/bin/ydotool key 125:1 29:1 210:1 210:0 29:0 125:0 ;;

			# Output volume up and down (•) 1.
			"Control change 0" )
			new_value="$data2"
			{ [ "$prev_0" -eq -1 ] || {
				# Volume up.
				[ "$new_value" -gt "$prev_0" ] && { ${pkgs.ydotool}/bin/ydotool key 115:1 115:0; }

				# Volume down.
				[ "$new_value" -lt "$prev_0" ] && { ${pkgs.ydotool}/bin/ydotool key 114:1 114:0; }
				[ "$new_value" -eq "$prev_0" ] && {

					# Volume up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.ydotool}/bin/ydotool key 115:1 115:0; }

					# Volume down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.ydotool}/bin/ydotool key 114:1 114:0; }
				}
			}; prev_0="$new_value"; }
			;;

			# Media volume up and down on (•) 2.
			"Control change 1" )
			new_value="$data2"
			{ [ "$prev_1" -eq -1 ] || {
				# Volume up.
				[ "$new_value" -gt "$prev_1" ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 115:1 115:0 42:0; }

				# Volume down.
				[ "$new_value" -lt "$prev_1" ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 114:1 114:0 42:0; }
				[ "$new_value" -eq "$prev_1" ] && {

					# Volume up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 115:1 115:0 42:0; }

					# Volume down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 114:1 114:0 42:0; }
				}
			}; prev_1="$new_value"; }
			;;

			# Input volume up and down on (•) 3.
			"Control change 2" )
			new_value="$data2"
			{ [ "$prev_2" -eq -1 ] || {
				# Volume up.
				[ "$new_value" -gt "$prev_2" ] && { ${pkgs.ydotool}/bin/ydotool key 125:1 115:1 115:0 125:0; }

				# Volume down.
				[ "$new_value" -lt "$prev_2" ] && { ${pkgs.ydotool}/bin/ydotool key 125:1 114:1 114:0 125:0; }
				[ "$new_value" -eq "$prev_2" ] && {

					# Volume up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.ydotool}/bin/ydotool key 125:1 115:1 115:0 125:0; }

					# Volume down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.ydotool}/bin/ydotool key 125:1 114:1 114:0 125:0; }
				}
			}; prev_2="$new_value"; }
			;;

			# External display brightness control on (•) 7.
			"Control change 6" )
			new_value="$data2"
			{ [ "$prev_6" -eq -1 ] || {
				# Brightness up.
				[ "$new_value" -gt "$prev_6" ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 225:1 225:0 42:0; }

				# Brightness down.
				[ "$new_value" -lt "$prev_6" ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 224:1 224:0 42:0; }
				[ "$new_value" -eq "$prev_6" ] && {

					# Brightness up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 225:1 225:0 42:0; }

					# Brightness down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.ydotool}/bin/ydotool key 42:1 224:1 224:0 42:0; }
				}
			}; prev_6="$new_value"; }
			;;

			# Internal display brightness control on (•) 8.
			"Control change 7" )
			new_value="$data2"
			{ [ "$prev_7" -eq -1 ] || {
				# Brightness up.
				[ "$new_value" -gt "$prev_7" ] && { ${pkgs.ydotool}/bin/ydotool key 225:1 225:0; }

				# Brightness down.
				[ "$new_value" -lt "$prev_7" ] && { ${pkgs.ydotool}/bin/ydotool key 224:1 224:0; }
				[ "$new_value" -eq "$prev_7" ] && {

					# Brightness up on repeated.
					[ "$new_value" -eq 127 ] && { ${pkgs.ydotool}/bin/ydotool key 225:1 225:0; }

					# Brightness down on repeated.
					[ "$new_value" -eq 0 ] && { ${pkgs.ydotool}/bin/ydotool key 224:1 224:0; }
				}
			}; prev_7="$new_value"; }
			;;
		esac
	done
'';
in {
	environment.systemPackages = [ midiplus-smartpad-macropad ];
	programs.ydotool.enable = true;
	users.users.${config.user.name}.extraGroups = [ "ydotool" ];
}