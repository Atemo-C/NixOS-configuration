{ config, pkgs, ... }: let

	Hyprland = config.home-manager.users.${config.userName}.wayland.windowManager.hyprland.enable;

in {

	# Enable Dconf if Hyprland is used.
	programs.dconf.enable = Hyprland;

	# XDG Desktop Portals settings.
	xdg.portal = {
		# List of packages that provide XDG Desktop Portal configuration.
		configPackages = if Hyprland then [
			# Hyprland Desktop Portal.
			pkgs.xdg-desktop-portal-hyprland

			# GTK Desktop Portal.
			pkgs.xdg-desktop-portal-gtk
		] else [];

		# Additional portals to add to the path.
		extraPortals = if Hyprland then [ pkgs.xdg-desktop-portal-gtk ] else [];

		# Enable XDG Desktop integration, a must on Wayland.
		enable = Hyprland;
	};

}
