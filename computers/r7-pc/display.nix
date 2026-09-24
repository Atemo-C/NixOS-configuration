{ config, lib, ... }: let
	# Settings for the Acer XV242Y.
	acer-xv242y = {
		# Full name of the monitor.
		name = "Acer Technologies XV242Y TL1EE0018521";

		# Physical connector of the monitor.
		# This may not be stable between reboots on multi-monitor or multi-GPU setups.
		# But it is a limitation we have to work with.
		connector = "DP-1";

		# Width (in pixels) of the monitor.
		width = 1920;

		# Height (in pixels) of the monitor.
		height = 1080;

		refreshRate = {
			# Refresh rate of the monitor.
			normal = 120;

			# Exact refresh rate of the monitor, required by Niri.
			exact = 119.982;
		};
	};
in {
	# Display configuration for the TTY.
	boot.kernelParams = [
		"video=${acer-xv242y.connector}:${toString acer-xv242y.width}x${toString acer-xv242y.height}@${toString acer-xv242y.refreshRate.normal}"
	];

	# Display configuration for the Noctalia Greeter.
	services.displayManager.noctalia-greeter.settings.output = {
		name = acer-xv242y.name;
		width = acer-xv242y.width;
		height = acer-xv242y.height;
		refresh_rate = acer-xv242y.refreshRate.normal;
	};

	# Display configuration for the Niri Wayland compositor.
	environment.etc."nixos/desktop/files/niri/output.kdl".text = ''
// This file is for the r7-pc in this configuration.
// /etc/nixos/computers/r7-pc/display.nix
output "${acer-xv242y.name}" {
	// Resolution and refresh rate.
	mode "${toString acer-xv242y.width}x${toString acer-xv242y.height}@${toString acer-xv242y.refreshRate.exact}"

	// Scaling.
	scale 1

	// Rotation.
	//transform "0"

	// Variable refresh rate on demand.
	variable-refresh-rate on-demand=true

	// Focus this monitor on startup.
	focus-at-startup
}
'';

	# Display configuration for the dedicated GameScope session.
	programs.steam.gamescopeSession.args = [
		"-r" "${toString acer-xv242y.refreshRate.normal}"
		"-O" "${acer-xv242y.connector}"
	];
}