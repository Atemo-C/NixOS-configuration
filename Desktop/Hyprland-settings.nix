# Documentation:
#───────────────
# • https://wiki.hyprland.org/
#
# Used Home Manager options:
#───────────────────────────
# • https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings

{ config, ... }: { home-manager.users.${config.custom.name}.wayland.windowManager.hyprland.settings = {

	# Animation settings.
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

	# Decoration settings.
	decoration = {
		# Blur settings.
		blur = {
			# Brightness modulation for blur. [0.0 - 2.0]
			brightness = "1";

			# Contrast modulation for blur. [0.0 - 2.0]
			contrast = "1";

			# Whether to enable kawase window background blur.
			enabled = false;

			# How much noise to apply. [0.0 - 2.0]
			noise = "0";

			# Blur size (distance).
			size = "3";

			# Increase saturation of blurred colors. [0.0 - 1.0]
			vibrancy = "0";

			# If enabled, floating windows will ignore tiled windows in their blur.
			# Only available if blur_new_optimizations is true (default).
			# Will reduce overhead on floating blur significantly.
			xray = true;
		};

		# Shadow’s color. Alpha dictates shadow’s opacity.
		"col.shadow" = "rgba(00b0ffcc)";

		# Inactive shadow color (if not set, will fall back to col.shadow).
		"col.shadow_inactive" = "rgba(000000cc)";

		# Whether to enable drop shadows on windows.
		drop_shadow = true;

		# Shadow range (“size”) in layout px.
		shadow_range = "6";

		# In what power to render the falloff (more power, the faster the falloff). [1 - 4]
		shadow_render_power = "10";
	};

	# Environment variables.
	env = [
		# Hyprland environment variables.
		## Enables more verbose logging.
#		"HYPRLAND_TRACE, 1"

		## Disables realtime priority setting by Hyprland.
#		"HYPRLAND_NO_RT, 1"

		## Disables the sd_notify calls.
#		"HYPRLAND_NO_SD_NOTIFY, 1"

		## Disables management of variables in systemd and dbus activation environments.
#		"HYPRLAND_NO_SD_VARS, 1"

		# Aquamarine environment variables.
		## Enables more verbose logging.
#		"AQ_TRACE, 1"

		## Set an explicit list of DRM devices (GPUs) to use.
		## It’s a colon-separated list of paths, with the first being the primary.
#		"AQ_DRM_DEVICES, /dev/dri/card1:/dev/dri/card0"

		## Disables explicit syncing on mgpu buffers.
#		"AQ_MGPU_NO_EXPLICIT, 1"

		## Disables modifiers for DRM buffers.
#		"AQ_NO_MODIFIERS, 1"

		# Toolkit backend variables.
		## GTK: Use wayland if available. If not: try x11, then any other GDK backend.
		"GDK_BACKEND, wayland, x11, *"

		## Qt: Use wayland if available, fall back to x11 if not.
		"QT_QPA_PLATFORM, wayland; xcb"

		## Qt: Enables automatic scaling, based on the monitor’s pixel density.
		"QT_AUTO_SCREEN_SCALE_FACTOR, 1"

		## Qt: Disables window decorations on Qt applications.
		"env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

		## Run SDL2 applications on Wayland.
		## Remove or set to x11 if games that provide older versions of SDL cause compatibility issues.
		"SDL_VIDEODRIVER, wayland"

		## This variable will force Clutter applications to try and use the Wayland backend for those that don't.
		"env = CLUTTER_BACKEND, wayland"
	];

	# General configuration options.
	general = {
		# Border color for the active window.
		"col.active_border" = "rgb(0080ff)";

		# Border color for inactive windows.
		"col.inactive_border" = "rgb(121212)";

		# Extends the area around the border where you can click and drag on.
		# Only used when general:resize_on_border is on.
		extend_border_grab_area = "10";

		# Gaps between windows, also supports css style gaps.
		# (top, right, bottom, left -> 5,10,15,20)
		gaps_in = "4";

		# Gaps between windows and monitor edges, also supports css style gaps.
		# (top, right, bottom, left -> 5,10,15,20)
		gaps_out = "0";

		# Which layout to use. [dwindle/master]
		layout = "dwindle";

		# Enables resizing windows by clicking and dragging on borders and gaps.
		resize_on_border = true;
	};

	# Dwindle layout configuration.
	dwindle = {
		# If enabled, allows a more precise control over the window split direction based on the cursor’s position.
		# The window is conceptually divided into four triangles, and cursor’s triangle determines the split direction.
		# This feature also turns on preserve_split.
		smart_split = true;

		# Whether to apply gaps when there is only one window on a workspace, aka. smart gaps.
		# No border - 1, With border - 2 [0/1/2]
		no_gaps_when_only = "1";
	};

	# Miscellaneous settings.
	misc = {
		# Whether to disable the random Hyprland logo / anime girl background.
		disable_hyprland_logo = true;

		# Whether to disable the Hyprland splash rendering (requires a monitor reload to take effect).
		disable_splash_rendering = true;

		# If DPMS is set to off, wake up the monitors if a key is pressed.
		key_press_enables_dpms = true;

		# If DPMS is set to off, wake up the monitors if the mouse moves.
		mouse_move_enables_dpms = true;

		# Controls the VRR (Adaptive Sync) of your monitors.
		# 0 - off, 1 - on, 2 - fullscreen only [0/1/2]
		vrr = "0";
	};

	# Monitor settings.
	# Name, Resolution@Rate, Position, Scale, Rotation.
	monitor = ", 1920x1080@120, 0x0, 1";

	# Rendering settings.
	render = {
		# Whether to enable explicit sync support. Requires a hyprland restart.
		# 0 - no, 1 - yes, 2 - auto based on the gpu driver
		explicit_sync = "0";

		# Enables direct scanout.
		# Direct scanout attempts to reduce lag when there is only one fullscreen application on a screen (e.g. game).
		# It is also recommended to set this to false if the fullscreen application shows graphical glitches.
		direct_scanout = true;
	};

	# Window rules.
	windowrulev2 = [
		# Floating windows [By title].
		"float, title: (About*)"
		"float, title: (Authentication Required)"
		"float, title: (Blender Preferences)"
		"float, title: (Close LibreWolf)"
		"float, title: (Emoji picker)"
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
		"float, class: (.gamescope-wrapped)"
		"float, class: (gcolor*)"
		"float, class: (lxqt-policykit-agent)"
		"float, class: (scrcpy)"
		"float, class: (waydroid.)"
		"float, class: (Waydroid)"
		"float, class: (xdg-desktop-portal-gtk)"
		"float, class: (xfburn)"
		"float, class: (zenity)"

		# Flotaing [By classa and title].
		"float, class: (UltiMaker-Cura), title: (Preferences)"

		# Tilling windows [By title].
		"tile, title: (Select an image)"
		"tile, title: (Kurso de Esperanto Kape)"
		"tile, title: (Sober)"

		# Event suppression [By title].
		"suppressevent maximize, title: (Revolt)"

		# Fullscreening windows [By class].
		"fullscreen, 1, class: (Better than Adventure*)"

		# XWayland videobridge-specific settings.
		"noanim, class: (xwaylandvideobridge)"
		"nofocus, class: (xwaylandvideobridge)"
		"noinitialfocus, class: (xwaylandvideobridge)"
		"opacity 0.0 override 0.0 override, class: (xwaylandvideobridge)"

		# CPU-X (TUI)-specific settings.
		"center, class: (CPU-X)"
		"float, class: (CPU-X)"
		"size 600 425, class: (CPU-X)"
	];

}; }
