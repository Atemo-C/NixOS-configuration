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

	dell-e207wfp = {
		# Full name of the monitor.
		name = "Dell Inc. DELL E207WFP CK62776BCE1L";

		# Physical connector of the monitor.
		# This may not be stable between reboots on multi-monitor or multi-GPU setups.
		# But it is a limitation we have to work with.
		connector = "DP-2";

		# Width (in pixels) of the monitor.
		width = 1680;

		# Height (in pixels) of the monitor.
		height = 1050;

		refreshRate = {
			# Refresh rate of the monitor.
			normal = 60;

			# Exact refresh rate of the monitor, required by Niri.
			exact = 59.883;
		};
	};
in {
	# Display configuration for the TTY.
	boot.kernelParams = [
		"video=${acer-xv242y.connector}:${toString acer-xv242y.width}x${toString acer-xv242y.height}@${toString acer-xv242y.refreshRate.normal}"
		"video=${dell-e207wfp.connector}:${toString dell-e207wfp.width}x${toString dell-e207wfp.height}@${toString dell-e207wfp.refreshRate.normal}"
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

	// Position of the monitor.
	position x=0 y=0
}

output "${dell-e207wfp.name}" {
	// Resolution and refresh rate.
	mode "${toString dell-e207wfp.width}x${toString dell-e207wfp.height}@${toString dell-e207wfp.refreshRate.exact}"

	// Scaling.
	scale 1

	// Rotation.
	// transform "0"

	// Position of the monitor.
	position x=${toString acer-xv242y.width} y=54
}
'';

	# Display configuration for the dedicated GameScope session.
	# Here, the single main monitor is preferred.
	programs.steam.gamescopeSession.args = [
		"-r" "${toString acer-xv242y.refreshRate.normal}"
		"-O" "${acer-xv242y.connector}"
	];
}