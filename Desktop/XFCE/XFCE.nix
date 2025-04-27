{ config, pkgs, ... }: {

	services = rec {
		# Select the XFCE desktop environment by default when logging in graphically.
		displayManager.defaultSession = (if xserver.desktopManager.xfce.enable then "xfce" else null);

		xserver = {
			# Enable the X server for XFCE.
			enable = xserver.desktopManager.xfce.enable;

			# Exclude undesired packages.
			excludePackages = [ (if xserver.desktopManager.xfce.enable then pkgs.xterm else null) ];

			desktopManager = {
				# Enable the XFCE desktop environment.
				xfce.enable = true;

				# Disable XTerm since XFCE's terminal is already present.
				xterm.enable = (if xserver.desktopManager.xfce.enable then false else true);
			};
		};
	};

}
