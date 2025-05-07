{ config, pkgs, ... }: let xfce = config.services.xserver.desktopManager.xfce.enable; in {

	services = {
		# Select the XFCE desktop environment by default when logging in graphically.
		displayManager.defaultSession = if xfce then "xfce" else null;

		xserver = {
			# Enable the X server for XFCE.
			enable = xfce;

			# Exclude undesired packages.
			excludePackages = if xfce then [ pkgs.xterm ] else [];

			desktopManager = {
				# Enable the XFCE desktop environment.
				xfce.enable = true;

				# Disable XTerm since XFCE's terminal is already present.
				xterm.enable = if xfce then false else null;
			};
		};
	};

}
