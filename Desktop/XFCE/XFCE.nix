{ config, pkgs, ... }: let XFCE = config.services.desktopManager.xfce.enable; in {

	services = {
		# Select the XFCE desktop environment by default when logging in graphically.
		displayManager.defaultSession = if XFCE then "xfce" else null;

		xserver = {
			# Enable the X server for XFCE.
			enable = XFCE;

			# Exclude undesired packages.
			excludePackages = if XFCE then [ pkgs.xterm ] else [];

			desktopManager = {
				# Enable the XFCE desktop environment.
				xfce.enable = true;

				# Disable XTerm since XFCE's terminal is already present.
				xterm.enable = if XFCE then false else null;
			};
		};
	};

}
