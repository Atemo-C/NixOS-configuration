{ config, pkgs, ... }: { home-manager.users.${config.userName}.wayland.windowManager.hyprland = {

	# Enable the Hyprland Wayland compositor.
	enable = true;

#	# Whether to enable XWayland support; Disabling it will give a Wayland-only desktop.
#	xwayland.enable = false;

#	# Whether to use the Legacy renderer; Mostly useful for older GPUs.
#	package = (pkgs.hyprland.override { legacyRenderer = true; });

	# Hyprland settings. They are arranged in a custom order.
	settings = rec {
		# Active window border colour and group background.
		general."col.active_border" = "rgb(0080ff)";
			group."col.border_active" = general."col.active_border";
			group.groupbar."col.active" = general."col.active_border";

		# Inactive window border colour and group background.
		general."col.inactive_border" = "rgb(1c1c1c)";
			group."col.border_inactive" = general."col.inactive_border";
			group.groupbar."col.inactive" = general."col.inactive_border";

		# Active window border colour and group background for locked groups and group-excluded windows.
		general."col.nogroup_border_active" = "rgb(ff4400)";
			group."col.border_locked_active" = general."col.nogroup_border_active";
			group.groupbar."col.locked_active" = general."col.nogroup_border_active";

		# Inactive  window border colour and group background for locked groups and group-excluded windows.
		general."col.nogroup_border" = general."col.inactive_border";
			group."col.border_locked_inactive" = general."col.inactive_border";
			group.groupbar."col.locked_inactive" = general."col.inactive_border";

		# Group settings.
		group = {
			# Whether dragging a window into an unlocked group will merge them.
			# 0 = Disabled | 1 = Enabled | 2 = Only when dragging into the groupbar.
			drag_into_group = 2;

			# Whether window groups can be dragged into other groups.
			merge_groups_on_drag = false;

			# Groupbar settings.
			groupbar = {
				# Height of the groupbar.
				height = 18;

				# Text color of groupbar title.
				text_color = "rgb(ffffff)";
			};
		};

		# General settings.
		general = {
			# Gaps between windows.
			gaps_in = 3;

			# Gaps between windows and monitor edges.
			gaps_out = 0;

			# Whether to enable resizing windows by click-and-dragging on borders and gaps.
			resize_on_border = true;

			# By how much to extend the area around the border where you can click-and-drag on.
			extend_border_grab_area = 10;

			# Whether to enable snapping for floating windows.
			snap.enabled = true;
		};

		# Shadows.
		decoration.shadow = {
#			# Whether to enable drop shadows on windows.
#			enable = false;

			# In what power to render the falloff; More power = The faster the falloff.
			render_power = 8;

			# Active shadow colour.
			color = "rgba(cccccccc)";

			# Inactive shadow colour.
			color_inactive = "rgba(000000cc)";
		};

		# Blur.
		decoration.blur = {
			# Whether to enable kawase window background blur.
			enabled = true;

			# Blur size (distance).
			size = 3;

			# Whether floating blurred windows should "xray" through tilled windows to save performances.
			xray = true;

			# How much noise to apply.
			noise = "0";

			# Contrast modulation for blur.
			contrast = "1";

			# Brightness modulation for blur.
			brightness = "1";

			# Increase saturation of blurred colours.
			vibrancy = "0";

			# How strong the effect of vibrancy is on dark areas.
			vibrancy_darkness = "0";
		};

		# Animations.
		animations = {
			# Whether to enable animations.
			enabled = true;

			# Whether to enable first launch animation.
			first_launch_animation = false;

			# Animation curves. [ Name, X0, Y0, X1, Y1 ]
			bezier = "Simple, 0.3, 1, 0.3, 1";

			# Animation settings. [ Type, Toggle, Time, Curve, Style ]
			animation = [ "global, 1, 3, Simple" ];
		};

		# Input settings.
		input = {
			# Whether to engage numlock by default.
			numlock_by_default = true;

			# The repeat rate for held-down keys, in repeats per second.
			repeat_rate = "30";

			# Delay before a held-down key is repeated, in milliseconds.
			repeat_delay = "250";

			# Sets the cursor acceleration profile.
			# Can be one of adaptive, flat, or custom.
			accel_profile = "flat";

			# Sets the scroll method.
			# Can be one of 2fg (2fingers), edge, on_button_down, no_scroll.
			scroll_method = "2fg";

			# Touchpad settings.
			touchpad = {
				# Whether to disable the touchpad while typing.
				disable_while_typing = false;

				# Button presses with 1, 2, or 3 figners will be mapped to:
				# LMB, RMB, and MMB respectively.
				# This disables interpretation of clicks based on location on the touchpad.
				clickfinger_behavior = true;
			};
		};

		# Miscellaneous settings.
		misc = {
			# Whether to disable the random Hyprland logo / anime girl background.
			disable_hyprland_logo = true;

			# Whether to disable the Hyprland splash rendering.
			disable_splash_rendering = true;

			# Change the background color when no wallpaper is set.
			background_color = "rgb(3b6ea5)";

			# If there is a fullscreen or maximized window, decide the desired behavior.
			# 0 (open behind), 1 (take over), 2 (unfullscreen/unmaximize).
			new_window_takes_over_fullscreen = 1;

			# The maximum limit for renderunfocused windows' fps in the background.
			render_unfocused_fps = 1;
		};

		# Workspace settings.
		workspace = [
			# Remove gaps when only one window is present.
			"w[tv1], gapsout:0, gapsin:0"
			"f[1],   gapsout:0, gapsin:0"
		];

		# Whether to enable back-and-forth between the current and last active workspaces.
		binds.workspace_back_and_forth = true;

		# Key bindings.
		bind = [
			# Workspace switching [AZERTY].
			"SUPER, ampersand,  workspace, 1"
			"SUPER, eacute,     workspace, 2"
			"SUPER, quotedbl,   workspace, 3"
			"SUPER, apostrophe, workspace, 4"
			"SUPER, parenleft,  workspace, 5"
			"SUPER, minus,      workspace, 6"
			"SUPER, egrave,     workspace, 7"
			"SUPER, underscore, workspace, 8"

			# Workspace switching [Numbers].
			"SUPER, 1, workspace, 1"
			"SUPER, 2, workspace, 2"
			"SUPER, 3, workspace, 3"
			"SUPER, 4, workspace, 4"
			"SUPER, 5, workspace, 5"
			"SUPER, 6, workspace, 6"
			"SUPER, 7, workspace, 7"
			"SUPER, 8, workspace, 8"

			# Moving the active window to a workspace [AZERTY].
			"SUPER SHIFT, ampersand,  movetoworkspace, 1"
			"SUPER SHIFT, eacute,     movetoworkspace, 2"
			"SUPER SHIFT, quotedbl,   movetoworkspace, 3"
			"SUPER SHIFT, apostrophe, movetoworkspace, 4"
			"SUPER SHIFT, parenleft,  movetoworkspace, 5"
			"SUPER SHIFT, minus,      movetoworkspace, 6"
			"SUPER SHIFT, egrave,     movetoworkspace, 7"
			"SUPER SHIFT, underscore, movetoworkspace, 8"

			# Moving the active window to a workspace [Numbers].
			"SUPER SHIFT, 1, movetoworkspace, 1"
			"SUPER SHIFT, 2, movetoworkspace, 2"
			"SUPER SHIFT, 3, movetoworkspace, 3"
			"SUPER SHIFT, 4, movetoworkspace, 4"
			"SUPER SHIFT, 5, movetoworkspace, 5"
			"SUPER SHIFT, 6, movetoworkspace, 6"
			"SUPER SHIFT, 7, movetoworkspace, 7"
			"SUPER SHIFT, 8, movetoworkspace, 8"

			# Window focus switching.
			"SUPER, left,  movefocus, l"
			"SUPER, down,  movefocus, d"
			"SUPER, up,    movefocus, u"
			"SUPER, right, movefocus, r"

			# Move window in stack.
			"SUPER SHIFT, left,  movewindow, l"
			"SUPER SHIFT, down,  movewindow, d"
			"SUPER SHIFT, up,    movewindow, u"
			"SUPER SHIFT, right, movewindow, r"

			# Toggles the current window's floating state.
			"SUPER, f, togglefloating"

			# Toggles the focused window's fullscreen mode.
			"SUPER SHIFT, f, fullscreen, 0"

			# Toggles the focused window's maximixed mode.
			"SUPER CONTROL, f, fullscreen, 1"

			# Focuses the next window on a workspace and brings it up.
			"ALT, Tab, cyclenext" "ALT, Tab, bringactivetotop"

			# Focuses the previous window on a workspace and brings it up.
			"ALT SHIFT, Tab, cyclenext, prev" "ALT SHIFT, Tab, bringactivetotop"

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
			"SUPER ALT, left,  moveintogroup, l"
			"SUPER ALT, down,  moveintogroup, d"
			"SUPER ALT, up,    moveintogroup, u"
			"SUPER ALT, right, moveintogroup, r"

			# Moves the active window out of a group (directional).
			"SUPER ALT SHIFT, left,  moveoutofgroup, l"
			"SUPER ALT SHIFT, down,  moveoutofgroup, d"
			"SUPER ALT SHIFT, up,    moveoutofgroup, u"
			"SUPER ALT SHIFT, right, moveoutofgroup, r"

			# Swaps the active window with the next in a group.
			"SUPER ALT, Tab, movegroupwindow, f"

			# Swaps the active window with the previous in a group.
			"SUPER ALT SHIFT, Tab, movegroupwindow, b"

			# Media control.
			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioStop, exec, playerctl stop"
			", XF86AudioPrev, exec, playerctl previous"
			", XF86AudioNext, exec, playerctl next"

			# Power buttons.
			'', XF86PowerOff,  exec, dash "/etc/nixos/Scripts/Power.sh"''
			'', XF86PowerDown, exec, dash "/etc/nixos/Scripts/Power.sh"''
			'', XF86Sleep,     exec, dash "/etc/nixos/Scripts/Power.sh"''
			'', XF86Suspend,   exec, dash "/etc/nixos/Scripts/Power.sh"''

			# Custom program launcher.
			''ALT, RETURN, exec, dash "/etc/nixos/Scripts/Programs.sh"''

			# Generil drun launcher.
			"ALT SHIFT, RETURN, exec, tofi-drun --drun-launch=true"

			# Emoji picking.
			"ALT SHIFT, E, exec, smile"

			# Terminal emulator
			"SUPER, RETURN, exec, alacritty"

			# Fullscreen screenshot (save).
			'', PRINT, exec, dash "/etc/nixos/Scripts/Screenshot.sh" --save monitor''

			# Fullscreen screenshot (copy).
			''CONTROL, PRINT, exec, dash "/etc/nixos/Scripts/Screenshot.sh" --copy monitor''

			# Region screenshot (save).
			''SHIFT, PRINT, exec, dash "/etc/nixos/Scripts/Screenshot.sh" --save area''

			# Region screenshot (copy).
			''CONTROL SHIFT, PRINT, exec, dash "/etc/nixos/Scripts/Screenshot.sh" --copy area''

			# All-monitors screenshot (save).
			''ALT, PRINT, exec, dash "/etc/nixos/Scripts/Screenshot.sh" --save all''

			# All-monitors screenshot (copy).
			''ALT SHIFT, PRINT, exec, dash "/etc/nixos/Scripts/Screenshot.sh" --copy all''

			# Select from the clipboard.
			"SUPER SHIFT, V, exec, clipman pick -t CUSTOM -T tofi"

			# Clear the clipboard.
			"SUPER CONTROL, V, exec, clipman clear --all & notify-send -t 1500 'Clipboard cleared'"

			# Opens a "primary" clipboard file.
			''ALT, V, exec, alacritty -e micro "$HOME/Documents/Clipboard.txt"''

			# Closing the active window.
			''SUPER SHIFT, C, killactive''

			# Issue a reload to force reload the config.
			''SUPER SHIFT CONTROL, R, exec, hyprctl reload''

			# Exits out of Hyprland.
			''SUPER SHIFT CONTROL, Q, exit''

			# Global bindings.
			# Disable them temporarily when configuring affected programs with said bindings.
			"ALT SUPER, R, pass, ^(com\.obsproject\.Studio)$"
			"ALT SUPER, S, pass, ^(com\.obsproject\.Studio)$"
		];

		# Repeatable key bindings.
		binde = [
			# Window resizing.
			"SUPER CONTROL, left,  resizeactive, -5 0"
			"SUPER CONTROL, down,  resizeactive, 0 5"
			"SUPER CONTROL, up,    resizeactive, 0 -5"
			"SUPER CONTROL, right, resizeactive, 5 0"

			# Audio volume [Output].
			", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-"
			", XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

			# Audio volume [Input].
			"SUPER, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.01+"
			"SUPER, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.01-"
			", XF86AudioMute,             exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

			# Audio volume [Player].
			"SHIFT, XF86AudioRaiseVolume, exec, playerctl volume 0.01%+"
			"SHIFT, XF86AudioLowerVolume, exec, playerctl volume 0.01%-"
		];

		# Mouse bindings.
		bindm = [
			# Window resizing and moving.
			"SUPER, mouse:272, movewindow"
			"SUPER, mouse:273, resizewindow"
		];

		# Window rules.
		windowrulev2 = [
			# Floating windows.
			"float, title: Export Image as.*"
			"float, class: (file-roller)"
			"float, class: (org.gnome.FileRoller)"
			"float, class: (galculator)"
			"float, class: (.gamescope-wrapped)"
			"float, class: (gcolor2)"
			"float, class: (gcolor3)"
			"float, class: (lagrange), title: (Preferences)"
			"float, class: (lxqt-policykit-agent)"
			"float, class: (org.gnome.Calculator)"
			"float, class: (scrcpy)"
			"float, class: (waydroid.)"
			"float, class: (Waydroid)"
			"float, class: (xdg-desktop-portal-gtk)"
			"float, class: (xfburn)"
			"float, class: (zenity)"
			"float, title: .*About.*"
			"float, title: (Authentication Required)"
			"float, title: (Blender Preferences)"
			"float, title: (Close LibreWolf)"
			"float, title: (Fabric Installer)"
			"float, title: (File Operation Progress)"
			"float, title: .*Opening.*, class:(librewolf)"
			"float, title: (PCSX2 Settings)"
			"float, title: (Picture-in-Picture)"
			"float, title: (Steam Settings)"
			"float, title: (waypaper)"
			"float, title: (Xwayland on :12)"

			# Tilling windows.
			"tile, title: (Kurso de Esperanto Kape)"
			"tile, title: (Select an image)"

			# Fullscreen windows.
			"fullscreen, 1, class: .*Better than Adventure.*"
			"fullscreen, 1, class: (Luanti)"

			# Render all fullscreen programs immediately apart from the ones with the `tear` tag.
			"prop immediate, fullscreen:1, tag: tear"

			# Tags for specific application types.
			"tag +term, class: (Alacritty|lxterminal|kitty|cool-retro-term.|XTerm)"
			"tag +tear, fullscreen:1, class: (steam_proton|steam_app|Luanti|com.mojang.minecraft|org.vinegarhq.Sober|.*Better than Adventrue.*|mcpelauncher-client)"

			# Disable blur for floating windows.
			"prop noblur, floating:1"

			# Enable blur only for specific tilled windows.
			"prop noblur, tag: negative:term"

			# Event suppression.
			"suppressevent maximize, title: (Revolt)"

			# Groupbar rules.
			"group, always, class: (.virt-manager-wrapped), title:(Virtual Machine Manager)"
			"group, always, class: (xclicker)"

			# XWayland videobridge-specific settings.
			"prop noanim,                       class: (xwaylandvideobridge)"
			"prop nofocus,                      class: (xwaylandvideobridge)"
			"noinitialfocus,                    class: (xwaylandvideobridge)"
			"opacity 0.0 override 0.0 override, class: (xwaylandvideobridge)"

			# Smile-specific settings.
			"center,       class: (it.mijorus.smile)"
			"float,        class: (it.mijorus.smile)"
			"size 320 410, class: (it.mijorus.smile)"

			# Replacement for Hyprland's "no gaps when only."
			"prop bordersize 0, floating:0, onworkspace:w[tv1]"
			"prop rounding 0,   floating:0, onworkspace:w[tv1]"
			"prop bordersize 0, floating:0, onworkspace:f[1]"
			"prop rounding 0,   floating:0, onworkspace:f[1]"

			# Border settings for some windows.
			"bordercolor rgb(00ffff) rgb(0080ff) 45deg, floating:1"
			"prop bordersize 2, floating:1"
			"bordercolor rgb(0CCC00), tag: term"
			"bordercolor rgb(ff00ff), title: micro.*, tag: term"
			"bordercolor rgb(ffc000), title: ssh.*, tag: term"
			"bordercolor rgb(ffc000), title: sftp.*, tag: term"
			"bordercolor rgb(FF0000), title: sudo.*, tag: term"
			"bordercolor rgb(FF0000), title: run0.*, tag: term"
			"bordercolor rgb(FF0000), title: 🔴 /.*, tag: term"
			"bordercolor rgb(FF0000), title: (Authentication Required)"
			"prop bordersize 2, title: (Authentication Required)"
			"prop bordersize 2, title: sudo.*, tag: term"
			"prop bordersize 2, title: run0.*, tag: term"
			"prop bordersize 2, title: 🔴 /.*, tag: term"
			"prop rounding 8, floating:1, class: (vesktop|sober_services)"
		];

		# Layer rules.
		layerrule = [
			# Blur for Waybar.
			"blur, waybar"

			# Blur and xray off for tofi/other lauchers.
			"blur, launcher"
			"xray 0, launcher"
		];

		# Environment variables.
		env = [
			# Toolkit backend variables.
			# GTK: Use wayland if available. If not: try x11, then any other GDK backend.
			"GDK_BACKEND, wayland, x11, *"

			# Qt: Use wayland if available, fall back to x11 if not.
			"QT_QPA_PLATFORM, wayland; xcb"

			# Qt: Enables automatic scaling, based on the monitor’s pixel density.
			"QT_AUTO_SCREEN_SCALE_FACTOR, 1"

			# Qt: Disables window decorations on Qt applications.
			"QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

			# Run SDL2 applications on Wayland.
			# Remove or set to x11 if games that provide older versions of SDL cause compatibility issues.
			"SDL_VIDEODRIVER, wayland"

			# This variable will force Clutter applications to try and use the Wayland backend for those that don't.
			"CLUTTER_BACKEND, wayland"

			# Hide cursor when taking screenshots with Grimblast.
			"GRIMBLAST_HIDE_CURSOR, 1"
		];

		# Dwindle layout settings.
		# If enabled, allows a more precise control over the window split direction based on the cursor's position.
		dwindle.smart_split = true;

		# Programs to start when logging into Hyprland.
		exec-once = [
#			# Screen sharing for legacy X11 programs.
#			"xwaylandvideobridge"
		];
	};

}; }
