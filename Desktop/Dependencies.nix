{ config, pkgs, ... }: {

	# Whether to enable Dconf, needed by some programs.
	programs.dconf.enable = true;

	# XDG Desktop Portals settings.
xdg.portal = {
			# List of packages that provide XDG Desktop Portal configuration.
			configPackages = [
				( if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
					pkgs.xdg-desktop-portal-hyprland else null )
				pkgs.xdg-desktop-portal-gtk
			];

		# Additional portals to add to the path.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

		# Whether to enable XDG Desktop integration.
		# Enabled by most desktop environments.
		# Required for Flatpaks to work.
		enable = true;
	};

}
