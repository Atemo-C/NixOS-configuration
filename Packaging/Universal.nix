{ config, pkgs, ... }: let Flatpak = config.services.flatpak.enable; in {

	# AppImages.
	programs.appimage = {
		# Whether to enable binfmt registration to run appimages via appimage-run seamlessly.
		binfmt = true;

		# Whether to enable the appimage-run wrapper script for executing AppImages on NixOS.
		enable = true;
	};

	# Whether to enable the Flatpak packaging system.
	services.flatpak.enable = true;

	# Configure basic XDG Desktop Portals if Flatpak is enabled.
	xdg.portal = {
		# List of packages that provide XDG Desktop Portal configuration.
		configPackages = if Flatpak then [ pkgs.xdg-desktop-portal-gtk ] else [];

		# Additional portals to add to the path.
		extraPortals = if Flatpak then [ pkgs.xdg-desktop-portal-gtk ] else [];

		# Enable XDG Desktop integration, a must for Flatpaks.
		enable = Flatpak;
	};

}
