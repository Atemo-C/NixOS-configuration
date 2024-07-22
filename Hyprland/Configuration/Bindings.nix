{ config, ... }: {

	# Bindings. Can be keyboard, mouse, both...
	# https://wiki.hyprland.org/Configuring/Binds/
	home-manager.users.${config.Custom.Name}.wayland.windowManager.hyprland.settings = {
		# Single-action bindings.
		bind = [
			# Workspace switching [AZERTY].
			"SUPER, ampersand, workspace, 1"
			"SUPER, eacute, workspace, 2"
			"SUPER, quotedbl, workspace, 3"
			"SUPER, apostrophe, workspace, 4"
			"SUPER, parenleft, workspace, 5"
			"SUPER, minus, workspace, 6"
			"SUPER, egrave, workspace, 7"
			"SUPER, underscore, workspace, 8"

			# Workspace switching [ISRT].
			"SUPER, I, workspace, 1"
			"SUPER, S, workspace, 2"
			"SUPER, R, workspace, 3"
			"SUPER, T, workspace, 4"
			"SUPER, N, workspace, 5"
			"SUPER, E, workspace, 6"
			"SUPER, A, workspace, 7"
			"SUPER, O, workspace, 8"

			# Workspace switching [Number].
			"SUPER, 1, workspace, 1"
			"SUPER, 2, workspace, 2"
			"SUPER, 3, workspace, 3"
			"SUPER, 4, workspace, 4"
			"SUPER, 5, workspace, 5"
			"SUPER, 6, workspace, 6"
			"SUPER, 7, workspace, 7"
			"SUPER, 8, workspace, 8"

			# Move window to workspace [AZERTY].
			"SUPER SHIFT, ampersand, movetoworkspace, 1"
			"SUPER SHIFT, eacute, movetoworkspace, 2"
			"SUPER SHIFT, quotedbl, movetoworkspace, 3"
			"SUPER SHIFT, apostrophe, movetoworkspace, 4"
			"SUPER SHIFT, parenleft, movetoworkspace, 5"
			"SUPER SHIFT, minus, movetoworkspace, 6"
			"SUPER SHIFT, egrave, movetoworkspace, 7"
			"SUPER SHIFT, underscore, movetoworkspace, 8"

			# Move window to workspace [ISRT].
			"SUPER SHIFT, I, movetoworkspace, 1"
			"SUPER SHIFT, S, movetoworkspace, 2"
			"SUPER SHIFT, R, movetoworkspace, 3"
			"SUPER SHIFT, T, movetoworkspace, 4"
			"SUPER SHIFT, N, movetoworkspace, 5"
			"SUPER SHIFT, E, movetoworkspace, 6"
			"SUPER SHIFT, A, movetoworkspace, 7"
			"SUPER SHIFT, O, movetoworkspace, 8"

			# Move window to workspace [Number].
			"SUPER SHIFT, 1, movetoworkspace, 1"
			"SUPER SHIFT, 2, movetoworkspace, 2"
			"SUPER SHIFT, 3, movetoworkspace, 3"
			"SUPER SHIFT, 4, movetoworkspace, 4"
			"SUPER SHIFT, 5, movetoworkspace, 5"
			"SUPER SHIFT, 6, movetoworkspace, 6"
			"SUPER SHIFT, 7, movetoworkspace, 7"
			"SUPER SHIFT, 8, movetoworkspace, 8"

			# Window focus switching.
			"SUPER, left, movefocus, l"
			"SUPER, down, movefocus, d"
			"SUPER, up, movefocus, u"
			"SUPER, right, movefocus, r"

			# Move window in stack.
			"SUPER SHIFT, left, movewindow, l"
			"SUPER SHIFT, down, movewindow, d"
			"SUPER SHIFT, up, movewindow, u"
			"SUPER SHIFT, right, movewindow, r"

			# Window state control.
			"SUPER, f, togglefloating"
			"SUPER SHIFT, f, fullscreen, 0"
			"SUPER CONTROL, f, fullscreen, 1"

			# Window switching with ALT+(SHIFT+)TAB.
			"ALT, Tab, cyclenext"
			"ALT, Tab, bringactivetotop"
			"ALT SHIFT, Tab, cyclenext, prev"
			"ALT SHIFT, Tab, bringactivetotop"

			# Media control.
			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioStop, exec, playerctl stop"
			", XF86AudioPrev, exec, playerctl previous"
			", XF86AudioNext, exec, playerctl next"

			# Power buttons.
			'', XF86PowerOff, exec, bash "/etc/nixos/Hyprland/Scripts/Power menu.sh"''
			'', XF86PowerDown, exec, bash "/etc/nixos/Hyprland/Scripts/Power menu.sh"''
			'', XF86Sleep, exec, bash "/etc/nixos/Hyprland/Scripts/Power menu.sh"''
			'', XF86Suspend, exec, bash "/etc/nixos/Hyprland/Scripts/Power menu.sh"''

			# Program launching
			''ALT, RETURN, exec, bash "/etc/nixos/Hyprland/Scripts/Program launcher.sh"''
			"ALT SHIFT, RETURN, exec, tofi-drun --drun-launch=true"

			# Screenshot
			'', PRINT, exec, bash "/etc/nixos/Hyprland/Scripts/Hyprshot single.sh"''
			''SHIFT, PRINT, exec, bash "/etc/nixos/Hyprland/Scripts/Hyprshot.sh"''

			# Emoji picking
			''ALT SHIFT, E, exec, alacritty -T "Emoji picker" -e bash "/etc/nixos/Hyprland/Scripts/Emoji.sh"''

			# Clipboard managing
			"SUPER SHIFT, V, exec, clipman pick -t CUSTOM -T tofi"
			"SUPER CONTROL, V, exec, clipman clear --all & notify-send -t 1000 'Clipboard cleared'"
			''ALT, V, exec, alacritty -e micro "$HOME/Documents/Clipboard.txt"''

			# Terminal emulator
			"SUPER, RETURN, exec, alacritty"

			# Screen shaders
			''ALT SHIFT, R, exec, hyprctl keyword decoration:screen_shader "$HOME/.config/hypr/shaders/crt.frag"''
			''ALT CONTROL, R, exec, hyprctl keyword decoration:screen_shader ""''

			# Closing window
			''SUPER SHIFT, C, killactive''

			# Hyprland control
			''SUPER SHIFT CONTROL, R, exec, hyprctl reload''
			''SUPER SHIFT CONTROL, Q, exit''

			# Global bindings. Disabled them temporarily when configuring affected programs with said bindings.
			# https://wiki.hyprland.org/Configuring/Binds/#global-keybinds
			"ALT SUPER, R, pass, ^(com\.obsproject\.Studio)$"
			"ALT SUPER, S, pass, ^(com\.obsproject\.Studio)$"
		];

		# Repeatable bindings.
		binde = [
			# Window resizing [Keyboard].
			"SUPER CONTROL, left,  resizeactive, -5 0"
			"SUPER CONTROL, down,  resizeactive, 0 5"
			"SUPER CONTROL, up,    resizeactive, 0 -5"
			"SUPER CONTROL, right, resizeactive, 5 0"

			# Audio volume [Output].
			", XF86AudioRaiseVolume, exec, amixer -q sset Master 1%+"
			", XF86AudioLowerVolume, exec, amixer -q sset Master 1%-"
			", XF86AudioMute,        exec, amixer -q sset Master toggle"

			# Audio volume [Input].
			"SUPER, XF86AudioRaiseVolume, exec, amixer -q sset Capture 1%+"
			"SUPER, XF86AudioLowerVolume, exec, amixer -q sset Capture 1%-"
			"SUPER, XF86AudioMute,        exec, amixer -q sset Capture toggle"

			# Audio volume [Player].
			"SHIFT, XF86AudioRaiseVolume, exec, playerctl volume 0.01%+"
			"SHIFT, XF86AudioLowerVolume, exec, playerctl volume 0.01%-"
		];

		# Mouse-only bindings.
		# Window resizing [Mouse].
		bindm = [
			"SUPER, mouse:272, movewindow"
			"SUPER, mouse:273, resizewindow"
		];
	};
}
