{ config, pkgs, ... }: {

	# Enable Dconf.
	programs.dconf.enable = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

	# XDG Desktop Portals settings.
	xdg.portal = {
		# List of packages that provide XDG Desktop Portal configuration.
		configPackages = [
			# Hyprland Desktop Portal.
			(if config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable then
				pkgs.xdg-desktop-portal-hyprland else null)

			# GTK Desktop Portal.
			pkgs.xdg-desktop-portal-gtk
		];

		# Additional portals to add to the path.
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

		# Enable XDG Desktop integration, a must on Wayland.
		enable = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;
	};

}
