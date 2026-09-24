{ config, lib, ... }: {
	# Display configuration for the TTY.
	boot.kernelParams = [ "video=DP-1:1920x1080@120" ];

	# Display configuration for the dedicated GameScope session.
	programs.steam.gamescopeSession.args = [ "-r" "120" "-O" "DP-1" ];

	# Display configuration for the Noctalia Greeter.
	services.displayManager.noctalia-greeter.settings.output = {
		name = "Acer Technologies XV242Y TL1EE0018521";
		width = 1920;
		height = 1080;
		refresh_rate = 120;
	};

	# Display configuration for the Niri Wayland compositor.
	environment.etc."nixos/desktop/files/niri/output.kdl".text = ''
// This file is for the r7-pc in this configuration.
// /etc/nixos/computers/r7-pc/display.nix
output "Acer Technologies XV242Y TL1EE0018521" {
	// Resolution and refresh rate.
		mode "1920x1080@119.982"

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
}