{ config, lib, pkgs, ... }: let

	xfce = config.services.xserver.desktopManager.xfce.enable;

in { services = {
	# Select the XFCE desktop environment by default when logging in graphically.
	displayManager.defaultSession = lib.optionalAttrs xfce "xfce";

	xserver = {
		# Enable the X server for XFCE.
		enable = xfce;

		# Exclude undesired packages.
		excludePackages = [ pkgs.xterm ];

		desktopManager = {
			# Enable the XFCE desktop environment.
			xfce.enable = true;

			# Disable XTerm since XFCE's terminal is already present.
			xterm.enable = lib.optionalAttrs xfce false;
		};
	};

}; }
