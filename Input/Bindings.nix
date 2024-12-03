# Documentation:
#───────────────
# • https://wiki.hyprland.org/Configuring/Binds/
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings

{ config, ... }: { home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings = {

	bind = [
		# Workspace switching (numerical).
		#─────────────────────────────────
		# [ AZERTY ]
		"SUPER, ampersand, workspace, 1"
		"SUPER, eacute, workspace, 2"
		"SUPER, quotedbl, workspace, 3"
		"SUPER, apostrophe, workspace, 4"
		"SUPER, parenleft, workspace, 5"
		"SUPER, minus, workspace, 6"
		"SUPER, egrave, workspace, 7"
		"SUPER, underscore, workspace, 8"

		# [ ISRT ]
		"SUPER, I, workspace, 1"
		"SUPER, S, workspace, 2"
		"SUPER, R, workspace, 3"
		"SUPER, T, workspace, 4"
		"SUPER, N, workspace, 5"
		"SUPER, E, workspace, 6"
		"SUPER, A, workspace, 7"
		"SUPER, O, workspace, 8"

		# [ Number ]
		"SUPER, 1, workspace, 1"
		"SUPER, 2, workspace, 2"
		"SUPER, 3, workspace, 3"
		"SUPER, 4, workspace, 4"
		"SUPER, 5, workspace, 5"
		"SUPER, 6, workspace, 6"
		"SUPER, 7, workspace, 7"
		"SUPER, 8, workspace, 8"

		# Move window to workspace (numerical).
		#──────────────────────────────────────
		# [ AZERTY ]
		"SUPER SHIFT, ampersand, movetoworkspace, 1"
		"SUPER SHIFT, eacute, movetoworkspace, 2"
		"SUPER SHIFT, quotedbl, movetoworkspace, 3"
		"SUPER SHIFT, apostrophe, movetoworkspace, 4"
		"SUPER SHIFT, parenleft, movetoworkspace, 5"
		"SUPER SHIFT, minus, movetoworkspace, 6"
		"SUPER SHIFT, egrave, movetoworkspace, 7"
		"SUPER SHIFT, underscore, movetoworkspace, 8"

		# [ ISRT ]
		"SUPER SHIFT, I, movetoworkspace, 1"
		"SUPER SHIFT, S, movetoworkspace, 2"
		"SUPER SHIFT, R, movetoworkspace, 3"
		"SUPER SHIFT, T, movetoworkspace, 4"
		"SUPER SHIFT, N, movetoworkspace, 5"
		"SUPER SHIFT, E, movetoworkspace, 6"
		"SUPER SHIFT, A, movetoworkspace, 7"
		"SUPER SHIFT, O, movetoworkspace, 8"

		# [ Number ]
		"SUPER SHIFT, 1, movetoworkspace, 1"
		"SUPER SHIFT, 2, movetoworkspace, 2"
		"SUPER SHIFT, 3, movetoworkspace, 3"
		"SUPER SHIFT, 4, movetoworkspace, 4"
		"SUPER SHIFT, 5, movetoworkspace, 5"
		"SUPER SHIFT, 6, movetoworkspace, 6"
		"SUPER SHIFT, 7, movetoworkspace, 7"
		"SUPER SHIFT, 8, movetoworkspace, 8"

		# Window focus switching (directional).
		#──────────────────────────────────────
		"SUPER, left, movefocus, l"
		"SUPER, down, movefocus, d"
		"SUPER, up, movefocus, u"
		"SUPER, right, movefocus, r"

		# Move window in stack (directional).
		#────────────────────────────────────
		"SUPER SHIFT, left, movewindow, l"
		"SUPER SHIFT, down, movewindow, d"
		"SUPER SHIFT, up, movewindow, u"
		"SUPER SHIFT, right, movewindow, r"

		# Window state control.
		#──────────────────────
		# Toggles the current window's floating state.
		"SUPER, f, togglefloating"

		# Toggles the focused window's fullscreen mode.
		"SUPER SHIFT, f, fullscreen, 0"

		# Toggles the focused window's maximixed mode.
		"SUPER CONTROL, f, fullscreen, 1"

		# Window switching.
		#──────────────────
		# Focuses the next window on a workspace and brings it up.
		"ALT, Tab, cyclenext" "ALT, Tab, bringactivetotop"

		# Focuses the previous window on a workspace and brings it up.
		"ALT SHIFT, Tab, cyclenext, prev" "ALT SHIFT, Tab, bringactivetotop"

		# Window groupping.
		#──────────────────
		# Toggles the current active window into a group.
		"SUPER ALT, t, togglegroup"

		# Switches to the next window in a group.
		"SUPER, Tab, changegroupactive, f"

		# Switches to the previous window in a group.
		"SUPER, Tab, changegroupactive, b"

		# Lock the focused group (toggle).
		# (The current group will not accept new windows or be moved to other groups.)
		"SUPER, l, lockactivegroup, toggle"

		# Moves the active window into a group in a specified direction (directional).
		"SUPER ALT, left, moveintogroup, l"
		"SUPER ALT, down, moveintogroup, d"
		"SUPER ALT, up, moveintogroup, u"
		"SUPER ALT, right, moveintogroup, r"

		# Moves the active window out of a group (directional).
		"SUPER ALT SHIFT, left, moveoutofgroup, l"
		"SUPER ALT SHIFT, down, moveoutofgroup, d"
		"SUPER ALT SHIFT, up, moveoutofgroup, u"
		"SUPER ALT SHIFT, right, moveoutofgroup, r"

		# Swaps the active window with the next in a group.
		"SUPER ALT, Tab, movegroupwindow, f"

		# Swaps the active window with the previous in a group.
		"SUPER ALT SHIFT, Tab, movegroupwindow, b"

		# Media control.
		#───────────────
		", XF86AudioPlay, exec, playerctl play-pause"
		", XF86AudioStop, exec, playerctl stop"
		", XF86AudioPrev, exec, playerctl previous"
		", XF86AudioNext, exec, playerctl next"

		# Power buttons.
		#───────────────
		'', XF86PowerOff, exec, bash "/etc/nixos/Desktop/Scripts/Power.sh"''
		'', XF86PowerDown, exec, bash "/etc/nixos/Desktop/Scripts/Power.sh"''
		'', XF86Sleep, exec, bash "/etc/nixos/Desktop/Scripts/Power.sh"''
		'', XF86Suspend, exec, bash "/etc/nixos/Desktop/Scripts/Power.sh"''

		# Programs/Launchers/Etc.
		#────────────────────────
		# Custom program launcher.
		''ALT, RETURN, exec, bash "/etc/nixos/Desktop/Scripts/Programs.sh"''

		# Generil drun launcher.
		"ALT SHIFT, RETURN, exec, tofi-drun --drun-launch=true"

		# Emoji picking.
		"ALT SHIFT, E, exec, smile"

		# Terminal emulator
		"SUPER, RETURN, exec, alacritty"

		# Screenshots.
		#─────────────
		# Fullscreen screenshot (save).
		'', PRINT, exec, bash "/etc/nixos/Desktop/Scripts/Screenshots/Fullscreen.sh"''

		# Region screenshot (save).
		''SHIFT, PRINT, exec, bash "/etc/nixos/Desktop/Scripts/Screenshots/Region.sh"''

		# Fullscreen screenshot (copy).
		''CONTROL, PRINT, exec, bash "/etc/nixos/Desktop/Scripts/Screenshots/Fullscreen-clipboard.sh"''

		# Region screenshot (copy).
		''CONTROL SHIFT, PRINT, exec, bash "/etc/nixos/Desktop/Scripts/Screenshots/Region-clipboard.sh"''

		# Clipboard management.
		#──────────────────────
		# Select from the clipboard.
		"SUPER SHIFT, V, exec, clipman pick -t CUSTOM -T tofi"

		# Clear the clipboard.
		"SUPER CONTROL, V, exec, clipman clear --all & notify-send -t 1500 'Clipboard cleared'"

		# Opens a "primary" clipboard file.
		''ALT, V, exec, alacritty -e micro "$HOME/Documents/Clipboard.txt"''

		# Termination of programs and Hyprland.
		#──────────────────────────────────────
		# Closing the active window.
		''SUPER SHIFT, C, killactive''

		# Hyprland controls
		#──────────────────
		# Issue a reload to force reload the config.
		''SUPER SHIFT CONTROL, R, exec, hyprctl reload''

		# Exits out of Hyprland.
		''SUPER SHIFT CONTROL, Q, exit''

		# Global bindings.
		#─────────────────
		# (Disabled them temporarily when configuring affected programs with said bindings.)
		"ALT SUPER, R, pass, ^(com\.obsproject\.Studio)$"
		"ALT SUPER, S, pass, ^(com\.obsproject\.Studio)$"
	];

	# Repeatable keyboard bindings.
	#──────────────────────────────
	binde = [
		# Window resizing [Keyboard] (directional).
		"SUPER CONTROL, left, resizeactive, -5 0"
		"SUPER CONTROL, down, resizeactive, 0 5"
		"SUPER CONTROL, up, resizeactive, 0 -5"
		"SUPER CONTROL, right, resizeactive, 5 0"

		# Audio volume [Output] (numerical).
		", XF86AudioRaiseVolume, exec, amixer -q sset Master 1%+"
		", XF86AudioLowerVolume, exec, amixer -q sset Master 1%-"
		", XF86AudioMute, exec, amixer -q sset Master toggle"

		# Audio volume [Input].
		"SUPER, XF86AudioRaiseVolume, exec, amixer -q sset Capture 1%+"
		"SUPER, XF86AudioLowerVolume, exec, amixer -q sset Capture 1%-"
		"SUPER, XF86AudioMute, exec, amixer -q sset Capture toggle"

		# Audio volume [Player].
		"SHIFT, XF86AudioRaiseVolume, exec, playerctl volume 0.01%+"
		"SHIFT, XF86AudioLowerVolume, exec, playerctl volume 0.01%-"
	];

	# Mouse bindings.
	#────────────────
	bindm = [
		"SUPER, mouse:272, movewindow"
		"SUPER, mouse:273, resizewindow"
	];

}; }
