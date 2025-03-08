{ config, pkgs, ... }: { xdg.portal = {

	# List of packages that provide XDG desktop portal configuration.
	configPackages = [
		pkgs.xdg-desktop-portal-hyprland
		pkgs.xdg-desktop-portal-gtk
	];

	# Additional portals to add to the path.
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	# Whether to enable XDG desktop integration.
	# Enabled by most desktop environments; Required for Flatpaks to work.
	enable = true;

}; }
