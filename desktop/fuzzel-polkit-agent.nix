# • Original shell script: https://codeberg.org/lukeflo/fuzzel-polkit-agent
#
# • License of the original shell script:
#────────────────────────────────────────
# MIT License
#
# Copyright (c) 2024 Florian Lukas
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

{ config, pkgs, ... }: let
	fuzzel-cmd-polkit = pkgs.writers.writeDashBin "fuzzel-cmd-polkit" ''
		# Check for any command-line arguments.
		[ "$#" -eq 0 ] || echo "Command-line arguments are not supported. Ignoring."

		# Check if the script is running under a Wayland environment.
		[ "$XDG_SESSION_TYPE" = "wayland" ] || {
			echo "[ !! ] This script is not running under a Wayland environment. Exiting."
			exit 1
		}

		# Detect whether the script is being run normally or being re-executed as a helper subprocess.
		if test "$1" != '_CALLED_INTERNALLY'; then
			prepParams() { for i in "$@"; do printf "'%s' " "$i"; done; }
			parameters="$(prepParams "$@")"

			exec ${pkgs.cmd-polkit}/bin/cmd-polkit-agent -s -c "$0 _CALLED_INTERNALLY $parameters*"
		else
			# Remove $1 (_CALLED_INTERNALLY) from the parametery array.
			shift 1

			# Process incoming messages one by one from stdin to $msg.
			while read -r msg; do
				# If a password prompt is asked, create and show it.
				if echo "$msg" | ${pkgs.jq}/bin/jq -e '.action == "request password"' 1>/dev/null 2>/dev/null; then
					# Get/set the password prompt.
					prompt=$(echo "$msg" | ${pkgs.jq}/bin/jq -rc '.prompt // "Password"')

					# Get/set the password message.
					message=$(echo "$msg" | ${pkgs.jq}/bin/jq -rc '.message // "Authentification required"')

					# Request the password with Fuzzel.
					response=$(${pkgs.fuzzel}/bin/fuzzel \
						--dmenu \
						--prompt-color=#ff0000ff \
						--prompt-only="$prompt"
						--mesg="$message" \
						--width=50 \
						--password "$@"
					)

					# Cancel authentification if no password was given;
					# Otherwise, respond with the given password.
					if test -z "$response"; then
						echo '{"action":"cancel"}'
					else
						echo "{\"action\":\"authenticate\",\"password\": \"$response\"}"
					fi
				fi
			done
		fi
	'';
in { environment.systemPackages = [ fuzzel-cmd-polkit ]; }