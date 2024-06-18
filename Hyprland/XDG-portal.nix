{ config, pkgs, ... }: {

	xdg.portal = {
		# Whether to enable XDG desktop integration.
		# https://search.nixos.org/options?channel=24.05&show=xdg.portal.enable
		enable = true;

		# Additional portals to add to path.
		# https://search.nixos.org/options?channel=24.05&show=xdg.portal.extraPortals
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

		# Packages that provide XDG deskop portal configuration.
		# https://search.nixos.org/options?channel=24.05&show=xdg.portal.configPackages
		configPackages = [
			pkgs.unstable.xdg-desktop-portal-hyprland
			pkgs.unstable.xdg-desktop-portal-gtk
		];
	};

}
