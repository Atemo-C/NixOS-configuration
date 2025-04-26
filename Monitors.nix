{ config, ... }: {

	# Settings for connected monitors during the boot process.
	boot.kernelParams = [
		# [Main] Center DisplayPort monitor.
		"video=DP-1:1920x1080@120"

		# [Secondary] Left HDMI-to-VGA monitor.
		"video=HDMI-A-1:1600x900@60"
	];

	home-manager.users.${config.userName} = {
		# Monitor settings for the Hyprland workspaces module in the Waybar bar.
		programs.waybar.settings.mainBar.settings."hyprland/workspaces" = { persistent-workspaces = {
			"DP-1" = [ 1 2 3 4 ];
			"HDMI-A-1" = [ 5 6 7 8 ];
		}; };

		# Monitor settings in the Hyprland Wayland compositor.
		wayland.windowManager.hyprland.settings = {
			# The name of the default monitor for the cursor to be set on startup.
			# See `hyprctl monitors` for the names of the currently attached monitor(s).
			# For Xwayland apps, you might also need to add `xrandr --output NAME --primary` in exec-once.
			cursor.default_monitor = "DP-1";

			# Set the default monitor for Xwayland programs.
			exec-once = [ "xrandr --output DP-1 --primary" ];

			misc = {
				# Control the VRR (Adaptive Sync) of the monitors.
				# 0 = off, 1 = on, 2 = fullscreen only, 3 = fullscreen with `video` or `game` content type.
				vrr = 3;

				# Whether to wake up the monitors if the mouse moves.
				mouse_move_enables_dpms = true;

				# Whether to wake up the monitors if a key is pressed.
				key_press_enables_dpms = true;
			};

			# Monitors resolution and refresh rate.
			monitor = [
				# [Main] Center DisplayPort monitor.
				"DP-1, 1920x1080@120, 0x0, 1"

				# [Secondary] Left HDMI-to-VGA monitor.
				"HDMI-A-1, 1600x900@60, -1600x147, 1"
			];

			# Assign specific workspaces to specific monitors.
			workspaces = [
				"1, monitor: DP-1"
				"2, monitor: DP-1"
				"3, monitor: DP-1"
				"4, monitor: DP-1"
				"5, monitor: HDMI-A-1"
				"6, monitor: HDMI-A-1"
				"7, monitor: HDMI-A-1"
				"8, monitor: HDMI-A-1"
			];
		};
	};

}
