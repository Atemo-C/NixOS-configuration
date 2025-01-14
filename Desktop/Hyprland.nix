{ config, pkgs, ... }: { home-manager.users.${config.custom.name}.wayland.windowManager.hyprland = {

	# Whether to enable the Hyprland Wayland compositor.
	enable = true;

	# The Hyprland package to use.
	package = pkgs.unstable.hyprland;

	# Hyprland settings.
	settings = {
		# General settings.
		general = {
			# Gaps between windows.
			gaps_in = 3;

			# Gaps between windows and monitor edges.
			gaps_out = 0;

			# Border color for inactive windows.
			"col.inactive_border" = "rgb(121212)";

			# Border color for the active window.
			"col.active_border" = "rgb(0080ff)";

			# Active border color for windows that cannot be added to a group.
			"col.nogroup_border" = "rgb(ff4400)";

			# Whether to enable resizing windows by clicking and dragging on borders and gaps.
			resize_on_border = true;

			# Extends the area around the border where you can click-and-drag on.
			extend_border_grab_area = 10;

			# Master switch for allowing tearing to occur.
			allow_tearing = true;

			# Window snapping.
			snap = {
				# Whether to enable snapping for floating windows.
				enabled = true;

				# If true, windows snap such that only noe border's worth of space is between them.
				border_overlap = true;
			};
		};

		# Decoratin settings.
		decoration = {
			# Blur settings.
			blur = {
				# Whether to enable kawase window background blur.
				enabled = true;

				# Blur size (distance).
				size = 3;

				# If enabled, floating windows will ignore tiled windows in their blur.
				# Will significantly reduce overhead on floating blur.
				xray = true;

				# How much noise to apply.
				noise = "0";

				# Contrast modulation for blur.
				contrast = "1";

				# Brightness modulation for blur.
				brightness = "1";

				# Increase saturation of blurred colors.
				vibrancy = "0";

				# How strong the effect of vibrancy is on dark areas.
				vibrancy_darkness = "0";
			};

			# Shadows settings.
			shadow = {
				# In hwat power to render the falloff. More power, the faster the falloff.
				render_power = 8;

				# Shadow color.
				color = "rgba(00b0ffcc)";

				# Inactive shadow color.
				color_inactive = "rgba(000000cc)";
			};
		};

		# Animations settings.
		animations = {
			# Whether to enable animations.
			enabled = true;

			# Whether to enable first launch animation.
			first_launch_animation = false;

			# Animation curves.
			# [ Name, X0, Y0, X1, Y1 ]
			bezier = "Simple, 0.3, 1, 0.3, 1";

			# Animation settings.
			# [ Type, Toggle, Time, Curve, Style ]
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

		# Group settings.
		group = {
			# Whether new windows will be automatically grouped into the focused unlock group.
			auto_group = true;

			# Whether dragging a window into an unlocked group will merge them.
			# 1 (disabled), 1 (enabled), 2 (only when dragging into the groupbar).
			drag_into_group = 2;

			# Whether window groups can be dragged into other groups.
			merge_groups_on_drag = false;

			# Active group border color.
			"col.border_active" = "rgb(0080ff)";

			# Inactive group border color.
			"col.border_inactive" = "rgb(121212)";

			# Active locked group boredr color.
			"col.border_locked_active" = "rgb(ff0000)";

			# Inactive locked group border color.
			"col.border_locked_inactive" = "rgb(a60000)";

			# Groupbar settings.
			groupbar = {
				# Font size of groupbar title.
				font_size = 11;

				# Height of the groupbar.
				height = 18;

				# Text color.
				text_color = "rgb(ffffff)";

				# Active group background color.
				"col.active" = "rgba(0067cccc)";

				# Inactive group background color.
				"col.inactive" = "rgba(004d99cc)";

				# Active locked group background color.
				"col.locked_active" = "rgba(e63d00cc)";

				# Inactive locked group background color.
				"col.locked_inactive" = "rgba(a62c00cc)";
			};
		};

		# Miscellaneous settings.
		misc = {
			# Whether to disable the random Hyprland logo / anime girl background.
			disable_hyprland_logo = true;

			# Whether to disable the Hyprland splash rendering.
			disable_splash_rendering = true;

			# Set the global default font to render the text, including debug fps/notifications, config errors, etc.
			font_family = "UbuntuMono Nerd Font";

			# Controls the VRR (Adaptive Sync) of the monitors.
			# 0 (off), 1 (on), 2 (fullscreen only).
			vrr = 0;

			# Whether to wake up the monitors if the mouse moves.
			mouse_move_enables_dpms = true;

			# Whether to wake up the monitors if a key is pressed.
			key_press_enables_dpms = true;

			# Change the background color when no wallpaper is set.
			background_color = "rgb(3b6ea5)";

			# If there is a fullscreen or maximized window, decide the desired behavior.
			# 0 (open behind), 1 (take over), 2 (unfullscreen/unmaximize).
			new_window_takes_over_fullscreen = 1;

			# The maximum limit for renderunfocused windows' fps in the background.
			render_unfocused_fps = 1;
		};

		# Bind settings.
		# Whether an attempt to switch to the currently focused workspace should instead switch to the previous one.
		# Akin to i3's auto_back_and_forth.
		binds.workspace_back_and_forth = true;

		# OpenGL settings.
		opengl = {
			# Reduces flickering on nvidia at the cost of possible frame drops on lower-end GPUs.
			# On non-nvidia, this is ignored.
			nvidia_anti_flicker = true;

			# Whether to force introspection at all times.
			# Introspection is aimed at reducing GPU usage in certain cases, but might cause glitches on nvidia.
			# 0 (nothing), 1 (force on), 2 (force on if nvidia).
			force_introspection = 2;
		};

		# Render settings.
		render = {
			# Whether to enable explicit sync support.
			# Requires a Hyprland restart.
			# 0 (no), 1 (yes), 2 (auto, based on the gpu driver).
			explicit_sync = 2;

			# Whether to enable explicit sync support for the KMS layer.
			# 0 (no), 1 (yes), 2 (auto, based on the gpu driver).
			explicit_sync_kms = 2;

			# Whether to enable direct scanout.
			# Direct scanout attempts to reduce lag when there is only one fullscreen application on a screen.
			# It is recommended to set this to false if fullscreen applications show graphical glitches.
			direct_scanout = true;
		};

		# Cursor settings.
		cursor = {
			# Whether to disable hardware cursors.
			# Set to 2 for auto, which disables them on nvidia, while keeping them enabled otherwise.
			no_hardware_cursors = 2;

			# Whether to disable scheduling new frames on cursor movement for fullscreen apps with VRR enabled.
			# This is to aviod framerate spikes.
			# Requires cursor:no_hardware_cursors = true;
			no_break_fs_vrr = true;

			# The name of the default monitor for the cursor to be set on startup.
			# See `hyprctl monitors` for names.
#			default_monitor = "DP-1";
		};

		# Keyboard bindings.
		bind = [
			# Workspace switching.
			# [ AZERTY ]
			"SUPER, ampersand, workspace, 1"
			"SUPER, eacute, workspace, 2"
			"SUPER, quotedbl, workspace, 3"
			"SUPER, apostrophe, workspace, 4"
			"SUPER, parenleft, workspace, 5"
			"SUPER, minus, workspace, 6"
			"SUPER, egrave, workspace, 7"
			"SUPER, underscore, workspace, 8"

			# [ Number ]
			"SUPER, 1, workspace, 1"
			"SUPER, 2, workspace, 2"
			"SUPER, 3, workspace, 3"
			"SUPER, 4, workspace, 4"
			"SUPER, 5, workspace, 5"
			"SUPER, 6, workspace, 6"
			"SUPER, 7, workspace, 7"
			"SUPER, 8, workspace, 8"

			# Move window to workspace.
			# [ AZERTY ]
			"SUPER SHIFT, ampersand, movetoworkspace, 1"
			"SUPER SHIFT, eacute, movetoworkspace, 2"
			"SUPER SHIFT, quotedbl, movetoworkspace, 3"
			"SUPER SHIFT, apostrophe, movetoworkspace, 4"
			"SUPER SHIFT, parenleft, movetoworkspace, 5"
			"SUPER SHIFT, minus, movetoworkspace, 6"
			"SUPER SHIFT, egrave, movetoworkspace, 7"
			"SUPER SHIFT, underscore, movetoworkspace, 8"

			# [ Number ]
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
			# Toggles the current window's floating state.
			"SUPER, f, togglefloating"

			# Toggles the focused window's fullscreen mode.
			"SUPER SHIFT, f, fullscreen, 0"

			# Toggles the focused window's maximixed mode.
			"SUPER CONTROL, f, fullscreen, 1"


			# Window switching.
			# Focuses the next window on a workspace and brings it up.
			"ALT, Tab, cyclenext" "ALT, Tab, bringactivetotop"

			# Focuses the previous window on a workspace and brings it up.
			"ALT SHIFT, Tab, cyclenext, prev" "ALT SHIFT, Tab, bringactivetotop"


			# Window groupping.
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
			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioStop, exec, playerctl stop"
			", XF86AudioPrev, exec, playerctl previous"
			", XF86AudioNext, exec, playerctl next"


			# Power buttons.
			'', XF86PowerOff, exec, bash "/etc/nixos/Scripts/Power.sh"''
			'', XF86PowerDown, exec, bash "/etc/nixos/Scripts/Power.sh"''
			'', XF86Sleep, exec, bash "/etc/nixos/Scripts/Power.sh"''
			'', XF86Suspend, exec, bash "/etc/nixos/Scripts/Power.sh"''


			# Programs/Launchers/Etc.
			# Custom program launcher.
			''ALT, RETURN, exec, bash "/etc/nixos/Scripts/Programs.sh"''

			# Generil drun launcher.
			"ALT SHIFT, RETURN, exec, tofi-drun --drun-launch=true"

			# Emoji picking.
			"ALT SHIFT, E, exec, smile"

			# Terminal emulator
			"SUPER, RETURN, exec, alacritty"


			# Screenshots.
			# Fullscreen screenshot (save).
			'', PRINT, exec, bash "/etc/nixos/Scripts/Screenshots/Fullscreen.sh"''

			# Region screenshot (save).
			''SHIFT, PRINT, exec, bash "/etc/nixos/Scripts/Screenshots/Region.sh"''

			# Fullscreen screenshot (copy).
			''CONTROL, PRINT, exec, bash "/etc/nixos/Scripts/Screenshots/Fullscreen-clipboard.sh"''

			# Region screenshot (copy).
			''CONTROL SHIFT, PRINT, exec, bash "/etc/nixos/Scripts/Screenshots/Region-clipboard.sh"''


			# Clipboard management.
			# Select from the clipboard.
			"SUPER SHIFT, V, exec, clipman pick -t CUSTOM -T tofi"

			# Clear the clipboard.
			"SUPER CONTROL, V, exec, clipman clear --all & notify-send -t 1500 'Clipboard cleared'"

			# Opens a "primary" clipboard file.
			''ALT, V, exec, alacritty -e micro "$HOME/Documents/Clipboard.txt"''

			# Termination of programs and Hyprland.
			# Closing the active window.
			''SUPER SHIFT, C, killactive''


			# Hyprland controls
			# Issue a reload to force reload the config.
			''SUPER SHIFT CONTROL, R, exec, hyprctl reload''

			# Exits out of Hyprland.
			''SUPER SHIFT CONTROL, Q, exit''


			# Global bindings.
			# (Disabled them temporarily when configuring affected programs with said bindings.)
			"ALT SUPER, R, pass, ^(com\.obsproject\.Studio)$"
			"ALT SUPER, S, pass, ^(com\.obsproject\.Studio)$"
		];

		# Repeatable keyboard bindings.
		binde = [
			# Window resizing [Keyboard].
			"SUPER CONTROL, left, resizeactive, -5 0"
			"SUPER CONTROL, down, resizeactive, 0 5"
			"SUPER CONTROL, up, resizeactive, 0 -5"
			"SUPER CONTROL, right, resizeactive, 5 0"

			# Audio volume [Output].
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
		bindm = [
			"SUPER, mouse:272, movewindow"
			"SUPER, mouse:273, resizewindow"
		];

		# Window rules.
		windowrulev2 = [
			# Floating windows [By title].
			"float, title: (About*)"
			"float, title: (Authentication Required)"
			"float, title: (Blender Preferences)"
			"float, title: (Close LibreWolf)"
			"float, title: (File Operation Progress)"
			"float, title: (Opening *), class:(librewolf)"
			"float, title: (PCSX2 Settings)"
			"float, title: (Picture-in-Picture)"
			"float, title: (Steam Settings)"
			"float, title: (waypaper)"
			"float, title: (Xwayland on :12)"

			# Floating windows [By class].
			"float, class: (file-roller)"
			"float, class: (galculator)"
			"float, class: (org.gnome.Calculator)"
			"float, class: (.gamescope-wrapped)"
			"float, class: (gcolor3)"
			"float, class: (gcolor2)"
			"float, class: (lxqt-policykit-agent)"
			"float, class: (scrcpy)"
			"float, class: (waydroid.)"
			"float, class: (Waydroid)"
			"float, class: (xdg-desktop-portal-gtk)"
			"float, class: (xfburn)"
			"float, class: (zenity)"

			# Floating windows [By both].
			"float, class: (lagrange), title: (Preferences)"

			# Flotaing [By classa and title].
			"float, class: (UltiMaker-Cura), title: (Preferences)"

			# Tilling windows [By title].
			"tile, title: (Select an image)"
			"tile, title: (Kurso de Esperanto Kape)"

			# Event suppression [By title].
			"suppressevent maximize, title: (Revolt)"

			# Fullscreening windows [By class].
			"fullscreen, 1, class: (Better than Adventure*)"

			# XWayland videobridge-specific settings.
			"prop noanim, class: (xwaylandvideobridge)"
			"prop nofocus, class: (xwaylandvideobridge)"
			"noinitialfocus, class: (xwaylandvideobridge)"
			"opacity 0.0 override 0.0 override, class: (xwaylandvideobridge)"

			# CPU-X (TUI)-specific settings.
			"center, class: (CPU-X)"
			"float, class: (CPU-X)"
			"size 600 425, class: (CPU-X)"

			# Smile-specific settings.
			"center, class: (it.mijorus.smile)"
			"float, class: (it.mijorus.smile)"
			"size 320 410, class: (it.mijorus.smile)"

			# Sober-specific settings.
			"tile, class: (sober)"
			"prop immediate, class: (sober)"

			# GIMP-specific settings.
			"center, title: (Open Image), class: (.gimp-2.10-wrapped_)"
			"size 800 600, title: (Open Image), class: (.gimp-2.10-wrapped_)"

			# Replacement for "no gaps when only."
			"prop bordersize 0, floating:0, onworkspace:w[tv1]"
			"prop rounding 0, floating:0, onworkspace:w[tv1]"
			"prop bordersize 0, floating:0, onworkspace:f[1]"
			"prop rounding 0, floating:0, onworkspace:f[1]"

			# Disable blur for floating windows.
			"prop noblur, floating:1"
		];

		# Layer rules.
		layerrule = [
			# Blur on Waybar
			"blur, waybar"
		];

		# Workspace settings.
		workspace = [
#			"1, monitor: DP-1"
#			"2, monitor: DP-1"
#			"3, monitor: DP-1"
#			"4, monitor: DP-1"
#			"5, monitor: HDMI-A-1"
#			"6, monitor: HDMI-A-1"
#			"7, monitor: HDMI-A-1"
#			"8, monitor: HDMI-A-1"

			# Replacement for "no gaps when only."
			"w[tv1], gapsout:0, gapsin:0"
			"f[1], gapsout:0, gapsin:0"
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
		];

		# Dwindle layout settings.
		# If enabled, allows a more precise control over the window split direction based on the cursor's position.
		dwindle.smart_split = true;

		# Monitor settings.
#		monitor = [
#			# [Main] Center DisplayPort monitor.
#			"DP-1, 1920x1080@120, 0x0, 1"
#
#			# [Secondary] Left HDMI-to-VGA monitor.
#			"HDMI-A-1, 1600x900@60, -1600x147, 1"
#		];

		# Programs to start when logging into Hyprland.
		exec-once = [
			# Set the default monitor for Xwayland programs.
#			"xrandr --output DP-1 --primary"

			# Screen sharing for legacy X11 programs.
#			"xwaylandvideobridge"

			# Wallpaper.
			"hyprpaper"

			# Policykit agent.
			"lxqt-policykit-agent"

			# Clipboard manager.
			"wl-paste -t text --watch clipman store --no-persist --max-items=100"

			# Audio tweaks with Easy Effects.
			"easyeffects --gapplication-service"
		];
	};

}; }
