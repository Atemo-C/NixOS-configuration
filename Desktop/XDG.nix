# Documentation:
#───────────────
# • https://wiki.archlinux.org/title/XDG_Desktop_Portal
#
# Used NixOS options:
#────────────────────
# • https://search.nixos.org/options?channel=24.05&show=xdg.portal.enable
# • https://search.nixos.org/options?channel=24.05&show=xdg.portal.extraPortals
# • https://search.nixos.org/options?channel=24.05&show=xdg.portal.configPackages

{ config, pkgs, ... }: { xdg.portal = {

	# Whether to enable XDG desktop integration.
	enable = true;

	# Additional portals to add to path.
	extraPortals = [ pkgs.unstable.xdg-desktop-portal-gtk ];

	# Packages that provide XDG desktop portal configuration.
	configPackages = [
		pkgs.unstable.xdg-desktop-portal-hyprland
		pkgs.unstable.xdg-desktop-portal-gtk
	];

}; }
